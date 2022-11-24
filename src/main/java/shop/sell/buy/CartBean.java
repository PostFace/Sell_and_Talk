package shop.sell.buy;

import java.util.Vector;

import shop.sell.ProductBean;
import shop.sell.ProductDao;

public class CartBean {
	//List �������̽� : �ߺ�O, ����O
		Vector<ProductBean> lists;//��ٱ��� ����
		
		public CartBean(){ 
			//public�� ���� ����:jsp���� ������ �����ϰ� �ϱ� ���� default�� ������ �ȵȴ�.
			lists=new Vector<ProductBean>();
		}	
		public void addProduct(String pnum,String oqty) {//��ǰ ��ȣ�� �ֹ� ������ ��´�.
			//System.out.println(pnum);
			ProductDao pdao=ProductDao.getInstance();
			ProductBean pb=pdao.getProductByNum(pnum);
			//System.out.println(pb.getPnum());
			
			for(int i=0;i<lists.size();i++) {
				if(lists.get(i).getPnum()==Integer.parseInt(pnum)) {
					lists.get(i).setPqty(lists.get(i).getPqty()+Integer.parseInt(oqty));
					lists.get(i).setTotalPrice(lists.get(i).getPrice()*lists.get(i).getPqty());
					lists.get(i).setTotalPoint(lists.get(i).getPoint()*lists.get(i).getPqty());
					return;
				}
			}
			
			pb.setPqty(Integer.parseInt(oqty));	
			pb.setTotalPrice(pb.getPrice()*pb.getPqty());
			pb.setTotalPoint(pb.getPoint()*pb.getPqty());
			lists.add(pb);					
			
			//System.out.println("lists"+lists.size());
		}
		public Vector<ProductBean> getLists(){		
			return lists;
		}
		public void setEdit(String pnum,String oqty) {
			for(ProductBean pb :lists) {
				if(pb.getPnum()==Integer.parseInt(pnum)) {
					pb.setPqty(Integer.parseInt(oqty));
					pb.setTotalPrice(pb.getPrice()*pb.getPqty());
					pb.setTotalPoint(pb.getPoint()*pb.getPqty());				
				}
			}
		}
		public boolean delProduct(String pnum) {
			boolean result=false;
			for(int i=0;i<lists.size();i++) {
				if(lists.get(i).getPnum()==Integer.parseInt(pnum)) {
					lists.remove(i);
					result=true;
					break;
				}
			}
			//for(ProductBean pb :lists) {
			//	if(pb.getPnum()==Integer.parseInt(pnum)) {
			//		lists.removeElement(pb);
			//		break;
			//	}
			//}
			return result;
		}
		public void removeAllProduct() {
			lists.removeAllElements();
		}
}
