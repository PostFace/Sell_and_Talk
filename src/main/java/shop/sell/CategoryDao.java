package shop.sell;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CategoryDao {

	private static CategoryDao instance;
	private Connection conn=null;
	private CategoryDao() {
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
	public static CategoryDao getInstance() {
		if(instance==null) {
			instance=new CategoryDao();
		}
		return instance;
	}
	public int insertCategory(CategoryBean cb) {
		String sql="insert into category values(catseq.nextval,?,?,?,?)";
		PreparedStatement ps=null;
		int result =-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cb.getCond());
			ps.setString(2,cb.getBrand());
			ps.setString(3,cb.getCode());
			ps.setString(4,cb.getCname());
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
	public CategoryBean setBean(ResultSet rs) throws SQLException {
		CategoryBean cb=new CategoryBean();
		cb.setCnum(rs.getInt("cnum"));
		cb.setCond(rs.getString("cond"));
		cb.setBrand(rs.getString("brand"));
		cb.setCode(rs.getString("code"));
		cb.setCname(rs.getString("cname"));
		
		return cb;
	}
	public ArrayList<CategoryBean> getAllCategory(){
		String sql="select * from category order by cnum";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<CategoryBean> lists=new ArrayList<CategoryBean>();
		try {
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				CategoryBean cb=setBean(rs);				
				lists.add(cb);
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
		return lists;
	}
	public ArrayList<CategoryBean> getCategory(String cond){
		String sql="select * from category where cond=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<CategoryBean> lists=new ArrayList<CategoryBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				CategoryBean cb=setBean(rs);				
				lists.add(cb);
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
		return lists;
	}
	public CategoryBean getCategoryByNum(String cnum) {
		String sql="select * from category where cnum=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		CategoryBean cb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cnum);
			rs=ps.executeQuery();
			if(rs.next()) {
				cb=setBean(rs);						
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
		return cb;
	}
	public int deleteCategory(String cnum) {
		String sql="delete category where cnum=?";
		int result=-1;
		PreparedStatement ps=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cnum);			
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
	public int updateCategory(CategoryBean cb) {
		String sql="update category set cond=?,brand=?,code=?,cname=? where cnum=?";
		PreparedStatement ps=null;
		int result =-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, cb.getCond());
			ps.setString(2, cb.getBrand());
			ps.setString(3, cb.getCode());
			ps.setString(4, cb.getCname());
			ps.setInt(5, cb.getCnum());
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
}
