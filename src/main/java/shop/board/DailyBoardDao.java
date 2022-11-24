package shop.board;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;



public class DailyBoardDao {
	private static DailyBoardDao instance;
	private Connection conn=null;
	private DailyBoardDao() {//getConnection의 내용을 생성자로 옮김. conn.close금지.
		Context initContext;
		try {
			initContext = new InitialContext(); //설정 정보
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds=(DataSource)envContext.lookup("jdbc/OracleDB");
			conn=ds.getConnection();
			System.out.println("conn:"+conn);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static DailyBoardDao getInstance() {
		if(instance==null) {
			instance=new DailyBoardDao();
		}
		return instance;
	}
	public int getArticleCount() {
		
		String sql="select count(*) as cnt from  daily_board";
		int result=-1;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			if(rs.next()) {
				result=rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	public ArrayList<DailyBoardBean> getArticles(int start,int end){
		
		String sql = "select num, writer, image, subject, reg_date, readcount,  content " ;		        
		sql += "from (select rownum as rank, num, writer, image, subject, reg_date, readcount, content ";
		sql += "from (select num, writer, image, subject, reg_date, readcount, content ";
		sql += "from  daily_board  ";
		sql += "order by num desc )) ";
		sql += "where rank between ? and ? ";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<DailyBoardBean> lists=new ArrayList<DailyBoardBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs=ps.executeQuery();
			while(rs.next()) {
				DailyBoardBean bb=new DailyBoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setImage(rs.getString("image"));
				bb.setSubject(rs.getString("subject"));				
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				bb.setContent(rs.getString("content"));
				
				lists.add(bb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
	}
	//글쓰기(원글)
	public int insertArticle(MultipartRequest mr) {
		
		String sql="insert into  daily_board(num,writer,image,subject,reg_date,content)"+
					" values( daily_board_seq.nextval,?,?,?,?,?)";
					//ref=>board_seq.currval
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("writer"));
			ps.setString(2, mr.getFilesystemName("image"));
			ps.setString(3,  mr.getParameter("subject"));		
			ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()) );	
			ps.setString(5, mr.getParameter("content"));
			result=ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	public DailyBoardBean getArticle(String num) {
		
		String sql2="update  daily_board set readcount=readcount+1 where num="+num;
		String sql="select * from  daily_board where num=?";
		String sql3="update members set exp=exp+1 where nickname=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		DailyBoardBean bb=null;
		try {
			ps=conn.prepareStatement(sql2);
			ps.executeUpdate();
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {
				bb=new DailyBoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setImage(rs.getString("image"));
				bb.setSubject(rs.getString("subject"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				bb.setContent(rs.getString("content"));
				ps=conn.prepareStatement(sql3);
				ps.setString(1, bb.getWriter());
				ps.executeQuery();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return bb;
	}
	
	public DailyBoardBean updateGetArticle(String num) {
		
		String sql="select * from  daily_board where num=?";
		DailyBoardBean bb=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {
				bb=new DailyBoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setImage(rs.getString("image"));
				bb.setSubject(rs.getString("subject"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				bb.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
		return bb;
	}
	public int updateArticle(MultipartRequest mr) {
		
		String sql1="select * from  daily_board where num=?";
		String sql2="update  daily_board set writer=?,image=?,subject=?,content=? where num=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql1);
			ps.setString(1, mr.getParameter("num"));
			rs=ps.executeQuery();
			if(rs.next()) {				
				if(rs.getString("writer").equals(mr.getParameter("writer"))||mr.getParameter("writer")=="admin") {
					ps=conn.prepareStatement(sql2);
					ps.setString(1, mr.getParameter("writer"));
					ps.setString(2, mr.getFilesystemName("image"));
					ps.setString(3, mr.getParameter("subject"));
					ps.setString(4, mr.getParameter("content"));
					ps.setString(5, mr.getParameter("num"));
					result=ps.executeUpdate();
				} else {
					result=-2;
				}
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
		return result;
	}
	public int deleteArticle(String num,String writer) {
		
		String sql="select writer from  daily_board where num=?";
		String sql2="delete  daily_board where num=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {				
				if(rs.getString("writer").equals(writer)||writer.equals("admin")) {
					ps=conn.prepareStatement(sql2);					
					ps.setString(1, num);
					result=ps.executeUpdate();
				} else {
					result=-2;
				}
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}				
		return result;
	}
}