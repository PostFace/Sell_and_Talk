package shop.sell;

import java.sql.Date;

public class ProductBean {
	private int pnum;
	private String pname;
	private String pcategory_fk;
	private String pseller;
	private String pimage;
	private int pqty;
	private int price;
	private String pspec;
	private String pcontents;
	private int point;
	private Date pinputdate;
	private String pcond;
	private String pbrand;
	private int totalPrice;
	private int totalPoint;
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public int getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}
	public String getPcond() {
		return pcond;
	}
	public void setPcond(String pcond) {
		this.pcond = pcond;
	}
	public String getPbrand() {
		return pbrand;
	}
	public void setPbrand(String pbrand) {
		this.pbrand = pbrand;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcategory_fk() {
		return pcategory_fk;
	}
	public void setPcategory_fk(String pcategory_fk) {
		this.pcategory_fk = pcategory_fk;
	}
	public String getPseller() {
		return pseller;
	}
	public void setPseller(String pseller) {
		this.pseller = pseller;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public int getPqty() {
		return pqty;
	}
	public void setPqty(int pqty) {
		this.pqty = pqty;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPspec() {
		return pspec;
	}
	public void setPspec(String pspec) {
		this.pspec = pspec;
	}
	public String getPcontents() {
		return pcontents;
	}
	public void setPcontents(String pcontents) {
		this.pcontents = pcontents;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Date getPinputdate() {
		return pinputdate;
	}
	public void setPinputdate(Date pinputdate) {
		this.pinputdate = pinputdate;
	}
	
}
