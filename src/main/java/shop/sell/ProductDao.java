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

import com.oreilly.servlet.MultipartRequest;

public class ProductDao {

	private static ProductDao instance;
	private Connection conn=null;
	private ProductDao() {
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
	public static ProductDao getInstance() {
		if(instance==null) {
			instance=new ProductDao();
		}
		return instance;
	}
	public int insertProduct(MultipartRequest mr) {
		String sql="insert into product(pnum,pname,pcategory_fk,pseller,pimage,pqty,price,pspec,"
				+ "pcontents,point,pinputdate,pcond,pbrand)"
				+" values(catprod.nextval,?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("pname"));
			String pcategory_fk=mr.getParameter("pcategory_fk");
			pcategory_fk +="/"+mr.getParameter("pcode");
			ps.setString(2, pcategory_fk);
			ps.setString(3, mr.getParameter("pseller"));
			String proname=mr.getFilesystemName("pimage");
			String proname1=mr.getFilesystemName("pimage1");
			String proname2=mr.getFilesystemName("pimage2");
			String proname3=mr.getFilesystemName("pimage3");
			if(proname1!=null){
				proname += "/"+proname1;
			}
			if(proname2!=null){
				proname += "/"+proname2;
			}
			if(proname3!=null){
				proname += "/"+proname3;
			}
			ps.setString(4, proname);
			ps.setInt(5, Integer.parseInt(mr.getParameter("pqty")));
			ps.setInt(6, Integer.parseInt(mr.getParameter("price")));
			ps.setString(7, mr.getParameter("pspec"));
			ps.setString(8, mr.getParameter("pcontents"));
			ps.setInt(9, Integer.parseInt(mr.getParameter("point")));
			ps.setString(10, mr.getParameter("pinputdate"));
			ps.setString(11, mr.getParameter("pcond"));
			ps.setString(12, mr.getParameter("pbrand"));
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
	public int updateProduct(MultipartRequest mr) {
		String sql="update product set pname=?,pbrand=?,pimage=?,"
				+ "pqty=?,price=?,pspec=?,pcontents=?,point=? where pnum=?";
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("pname"));
			ps.setString(2, mr.getParameter("pbrand"));
			String proname=mr.getFilesystemName("pimage");
			String proname1=mr.getFilesystemName("pimage1");
			String proname2=mr.getFilesystemName("pimage2");
			String proname3=mr.getFilesystemName("pimage3");
			if(proname==null){
				proname =mr.getParameter("pimages");
			}
			if(proname1!=null){
				proname += "/"+proname1;
			} else {
				if(mr.getParameter("pimages1")!=null){
					proname +="/"+mr.getParameter("pimages1");
				}
			}
			if(proname2!=null){
				proname += "/"+proname2;
			} else {
				if(mr.getParameter("pimages2")!=null){
					proname +="/"+mr.getParameter("pimages2");
				}
			}
			if(proname3!=null){
				proname += "/"+proname3;
			} else {
				if(mr.getParameter("pimages3")!=null){
					proname +="/"+mr.getParameter("pimages3");
				}
			}			
			ps.setString(3, proname);
			ps.setInt(4, Integer.parseInt(mr.getParameter("pqty")));
			ps.setInt(5, Integer.parseInt(mr.getParameter("price")));
			ps.setString(6, mr.getParameter("pspec"));
			ps.setString(7, mr.getParameter("pcontents"));
			ps.setInt(8, Integer.parseInt(mr.getParameter("point")));
			ps.setInt(9, Integer.parseInt(mr.getParameter("pnum")));
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
	public ProductBean insert(ResultSet rs) throws SQLException {
		ProductBean pb=new ProductBean();
		pb.setPnum(rs.getInt("pnum"));
		pb.setPname(rs.getString("pname"));
		pb.setPcategory_fk(rs.getString("pcategory_fk"));
		pb.setPseller(rs.getString("pseller"));
		pb.setPimage(rs.getString("pimage"));
		pb.setPqty(rs.getInt("pqty"));
		pb.setPrice(rs.getInt("price"));
		pb.setPspec(rs.getString("pspec"));
		pb.setPcontents(rs.getString("pcontents"));
		pb.setPoint(rs.getInt("point"));
		pb.setPinputdate(rs.getDate("pinputdate"));
		pb.setPcond(rs.getString("pcond"));
		pb.setPbrand(rs.getString("pbrand"));
		
		return pb;
	}
	public ArrayList<ProductBean> getAllProduct(String cond){
		String sql="select * from product where pcond=?";
		ArrayList<ProductBean> lists =new ArrayList<ProductBean>();
		PreparedStatement ps =null;
		ResultSet rs= null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public ArrayList<ProductBean> getSellerProduct(String seller){
		String sql="select * from product where pseller=?";
		ArrayList<ProductBean> lists =new ArrayList<ProductBean>();
		PreparedStatement ps =null;
		ResultSet rs= null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,seller);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public int deleteProduct(String pnum) {
		String sql="delete product where pnum=?";
		PreparedStatement ps=null;
		int result=-1;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, pnum);
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
	public ProductBean getProductByNum(String pnum){
		String sql="select * from product where pnum=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ProductBean pb=null;
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, pnum);
			rs=ps.executeQuery();
			if(rs.next()) {
				pb=insert(rs);											
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
		return pb;
	}
	public ArrayList<ProductBean> getProductByCode(String code,String cond){
		String sql="select * from product where pcategory_fk like ? and pcond=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ProductBean> lists=new ArrayList<ProductBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, code+"%");
			ps.setString(2, cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public ArrayList<ProductBean> getProductBySpec(String spec,String cond){
		String sql="select * from product where pspec=? and pcond=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ProductBean> lists=new ArrayList<ProductBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, spec);
			ps.setString(2, cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public ArrayList<ProductBean> getProductBySearchSpec(String search,String spec,String cond){
		String sql="select * from product where pname like ? and pspec=? and pcond=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ProductBean> lists=new ArrayList<ProductBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, spec);
			ps.setString(3, cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public ArrayList<ProductBean> getAllProductBySpec(String spec){
		String sql="select * from product where pspec=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ProductBean> lists=new ArrayList<ProductBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, spec);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	public ArrayList<ProductBean> getAllProductBySearch(String search,String cond){
		String sql="select * from product where pname like ? and pcond=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<ProductBean> lists=new ArrayList<ProductBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+search+"%");
			ps.setString(2, cond);
			rs=ps.executeQuery();
			while(rs.next()) {
				ProductBean pb=insert(rs);
				lists.add(pb);
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
	
}
