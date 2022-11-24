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

public class ReBoardDao {
	private static ReBoardDao instance;
	private Connection conn=null;
	private ReBoardDao() {//getConnection의 내용을 생성자로 옮김. conn.close금지.
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
	public static ReBoardDao getInstance() {
		if(instance==null) {
			instance=new ReBoardDao();
		}
		return instance;
	}
	public int insertReple(ReBoardBean rb) {
		String sql="insert into reboard values(reboard_seq.nextval,?,?,?)";
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1,rb.getRenum());
			ps.setString(2, rb.getWriter());
			ps.setString(3, rb.getContent());
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
	public ArrayList<ReBoardBean> getRepleByRenum(int renum){
		String sql="select * from reboard where renum=? order by num";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ReBoardBean> lists= new ArrayList<ReBoardBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, renum);
			rs=ps.executeQuery();
			if(rs.next()) {
				lists= new ArrayList<ReBoardBean>();
				while(rs.next()) {
					ReBoardBean rb=new ReBoardBean();
					rb.setContent(rs.getString("content"));
					rb.setWriter(rs.getString("writer"));
					lists.add(rb);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(lists.size());
		return lists;
	}
}
