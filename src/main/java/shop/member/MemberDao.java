package shop.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDao { 

	private static MemberDao instance;
	private Connection conn=null;
	private MemberDao() {
		Context initContext;
		try {
			initContext = new InitialContext(); //설정 정보
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds=(DataSource)envContext.lookup("jdbc/OracleDB");
			conn=ds.getConnection();
			System.out.println("conn:"+conn);
		} catch (NamingException e) {
			System.out.println("에러발생");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("에러발생 2");
			e.printStackTrace();
		}	
	}
	public static MemberDao getInstance() {
		if(instance==null) {
			instance=new MemberDao();
		}
		return instance;
	}
	public int insertMember(MemberBean mb) {
		String sql="insert into members(no,name,nickname,id,password,rrn1,rrn2,email,hp1,hp2,hp3) "
				+" values(memseq.nextval,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps=null;
		int result =-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mb.getName());
			ps.setString(2, mb.getNickname());
			ps.setString(3, mb.getId());
			ps.setString(4, mb.getPassword());
			ps.setInt(5, mb.getRrn1());
			ps.setInt(6, mb.getRrn2());
			ps.setString(7, mb.getEmail());
			ps.setString(8, mb.getHp1());
			ps.setString(9, mb.getHp2());
			ps.setString(10, mb.getHp3());
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
	public MemberBean getMemberByRrn(String name,String rrn1,String rrn2) {
		String sql="select * from members where name=? and rrn1=? and rrn2=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		MemberBean mb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);
			rs=ps.executeQuery();
			if(rs.next()) {
				mb=new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPassword(rs.getString("password"));
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
		return mb;
	}
	public MemberBean getMemberByLogin(String id,String password) {
		String sql="select * from members where id=? and password=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		MemberBean mb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			rs=ps.executeQuery();
			if(rs.next()) {
				mb=getMemberBean(rs);
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
		return mb;
	}
	private MemberBean getMemberBean(ResultSet rs) throws SQLException {
		MemberBean mb=new MemberBean();
		mb.setNo(rs.getInt("no"));
		mb.setName(rs.getString("name"));
		mb.setNickname(rs.getString("nickname"));
		mb.setId(rs.getString("id"));
		mb.setPassword(rs.getString("password"));
		mb.setRrn1(rs.getInt("rrn1"));
		mb.setRrn2(rs.getInt("rrn2"));
		mb.setEmail(rs.getString("email"));
		mb.setHp1(rs.getString("hp1"));
		mb.setHp2(rs.getString("hp2"));
		mb.setHp3(rs.getString("hp3"));
		mb.setJoindate(rs.getDate("joindate"));
		mb.setExp(rs.getInt("exp"));
		return mb;
	}
	public boolean searchId(String id) {
		String sql="select id from members where id=?";
		boolean isCheck=false;
		PreparedStatement ps=null;
		ResultSet rs=null;		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);						
			rs=ps.executeQuery();
			if(rs.next()) {
				isCheck=true;
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
		
		return isCheck;
	}
	public MemberBean getProfile(String id) {
		String sql="select * from members where id=?";
		MemberBean mb=null;
		PreparedStatement ps=null;
		ResultSet rs=null;		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);						
			rs=ps.executeQuery();
			if(rs.next()) {
				mb=new MemberBean();
				mb=getMemberBean(rs);
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
		
		return mb;
	}
	public MemberBean getProfileByNick(String nick) {
		String sql="select * from members where nickname=?";
		MemberBean mb=null;
		PreparedStatement ps=null;
		ResultSet rs=null;		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, nick);						
			rs=ps.executeQuery();
			if(rs.next()) {
				mb=new MemberBean();
				mb=getMemberBean(rs);
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
		
		return mb;
	}
	
}
