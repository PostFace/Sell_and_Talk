package shop.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class BoardDao {
	private static BoardDao instance;
	private Connection conn=null;
	private BoardDao() {//getConnection의 내용을 생성자로 옮김. conn.close금지.
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
	public static BoardDao getInstance() {
		if(instance==null) {
			instance=new BoardDao();
		}
		return instance;
	}
	public int getArticleCount() {
		
		String sql="select count(*) as cnt from board";
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
	public ArrayList<BoardBean> getArticles(int start,int end){
		
		String sql = "select num, writer, email, subject, reg_date, readcount, ref, re_step, re_level, content, ip " ;		        
		sql += "from (select rownum as rank, num, writer, email, subject, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from (select num, writer, email, subject, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<BoardBean> lists=new ArrayList<BoardBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs=ps.executeQuery();
			while(rs.next()) {
				BoardBean bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setEmail(rs.getString("email"));
				bb.setSubject(rs.getString("subject"));				
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setIp(rs.getString("ip"));
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
	public int insertArticle(BoardBean bb) {
		
		String sql="insert into board(num,writer,email,subject,reg_date,ref,re_step,re_level,content,ip)"+
					" values(board_seq.nextval,?,?,?,?,board_seq.currval,?,?,?,?)";
					//ref=>board_seq.currval
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getEmail());
			ps.setString(3, bb.getSubject());
			
			ps.setTimestamp(4, bb.getReg_date());
			ps.setInt(5,0); //re_step
			ps.setInt(6,0); //re_level
			ps.setString(7, bb.getContent());
			ps.setString(8, bb.getIp());
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
	public BoardBean getArticle(String num) {
		
		String sql2="update board set readcount=readcount+1 where num="+num;
		String sql="select * from board where num=?";
		String sql3="update members set exp=exp+1 where nickname=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		BoardBean bb=null;
		try {
			ps=conn.prepareStatement(sql2);
			ps.executeUpdate();
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {
				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setEmail(rs.getString("email"));
				bb.setSubject(rs.getString("subject"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setIp(rs.getString("ip"));
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
	public int replyArticle(BoardBean bb) {
		
		String sql="insert into board(num,writer,email,subject,reg_date,ref,re_step,re_level,content,ip)"+
				" values(board_seq.nextval,?,?,?,?,?,?,?,?,?)";
		String sql2="update board set re_step=re_step+1 where ref=? and re_step>?";		
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql2);
			ps.setInt(1, bb.getRef());
			ps.setInt(2, bb.getRe_step());
			ps.executeUpdate();
			ps=conn.prepareStatement(sql);
			ps.setString(1, bb.getWriter());
			ps.setString(2, bb.getEmail());
			ps.setString(3, bb.getSubject());
			ps.setTimestamp(4, bb.getReg_date());
			ps.setInt(5,bb.getRef()); 
			ps.setInt(6,(bb.getRe_step()+1)); 
			ps.setInt(7,(bb.getRe_level()+1)); 
			ps.setString(8, bb.getContent());
			ps.setString(9, bb.getIp());
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
	public BoardBean updateGetArticle(String num) {
		
		String sql="select * from board where num=?";
		BoardBean bb=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, num);
			rs=ps.executeQuery();
			if(rs.next()) {
				bb=new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setEmail(rs.getString("email"));
				bb.setSubject(rs.getString("subject"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRef(rs.getInt("ref"));
				bb.setRe_step(rs.getInt("re_step"));
				bb.setRe_level(rs.getInt("re_level"));
				bb.setContent(rs.getString("content"));
				bb.setIp(rs.getString("ip"));
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
	public int updateArticle(BoardBean bb) {
		
		String sql1="select * from board where num=?";
		String sql2="update board set writer=?,email=?,subject=?,content=? where num=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql1);
			ps.setInt(1, bb.getNum());
			rs=ps.executeQuery();
			if(rs.next()) {				
				if(rs.getString("writer").equals(bb.getWriter())||bb.getWriter()=="admin") {
					ps=conn.prepareStatement(sql2);
					ps.setString(1, bb.getWriter());
					ps.setString(2, bb.getEmail());
					ps.setString(3, bb.getSubject());
					ps.setString(4, bb.getContent());
					ps.setInt(5, bb.getNum());
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
		
		String sql="select writer from board where num=?";
		String sql2="delete board where num=?";
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