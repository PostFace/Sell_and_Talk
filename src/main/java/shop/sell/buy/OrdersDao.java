package shop.sell.buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import shop.sell.ProductBean;


public class OrdersDao {

	private Connection conn=null;
	public OrdersDao() {//getConnection의 내용을 생성자로 옮김. conn.close금지.
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
	public int insertOrders(int mno,CartBean cbean) {
		Vector<ProductBean> lists=cbean.getLists();
		int count=0;
		for(ProductBean pb: lists) {	
			
			String sql="insert into orders(orderId,sellerId,memno,pnum,qty,amount) values(orderseq.nextval,?,?,?,?,?)";
			PreparedStatement ps=null;
			int result=-1;
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, pb.getPseller());
				ps.setInt(2, mno);
				ps.setInt(3, pb.getPnum());
				ps.setInt(4, pb.getPqty());
				ps.setInt(5, pb.getTotalPrice());
				result=ps.executeUpdate();
				if(result>0) {
					count++;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if(ps !=null)
						ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return count;
	}
	public ArrayList<OrdersBean> getOrderList(String mid){
		String sql="select m.name mname, m.id mid,p.pseller pseller, p.pname pname, o.qty oqty, o.amount oamount"
				+" from (members m inner join orders o on m.no = o.MEMNO) "
				+" inner join product p on o.pnum=p.pnum "
				+" where m.id=?";
		PreparedStatement ps=null;
		ResultSet rs=null;
		ArrayList<OrdersBean> lists=new ArrayList<OrdersBean>();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, mid);
			rs=ps.executeQuery();
			while(rs.next()) {
				OrdersBean ob=new OrdersBean();
				ob.setMid(rs.getString("mid"));
				ob.setMname(rs.getString("mname"));
				ob.setQty(rs.getInt("oqty"));
				ob.setAmount(rs.getInt("oamount"));				
				ob.setPname(rs.getString("pname"));
				ob.setSellerId(rs.getString("pseller"));
				lists.add(ob);	
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
