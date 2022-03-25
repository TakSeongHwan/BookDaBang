package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class Sales {
	private int no; 
	private int orderno; 
	private int product_no; 
	private int productqtt; 
	private int total_price; 
	private Timestamp purchasetime;
	public Sales() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Sales(int no, int orderno, int product_no, int productqtt, int total_price, Timestamp purchasetime) {
		super();
		this.no = no;
		this.orderno = orderno;
		this.product_no = product_no;
		this.productqtt = productqtt;
		this.total_price = total_price;
		this.purchasetime = purchasetime;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getOrderno() {
		return orderno;
	}
	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getProductqtt() {
		return productqtt;
	}
	public void setProductqtt(int productqtt) {
		this.productqtt = productqtt;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public Timestamp getPurchasetime() {
		return purchasetime;
	}
	public void setPurchasetime(Timestamp purchasetime) {
		this.purchasetime = purchasetime;
	}
	@Override
	public String toString() {
		return "Sales [no=" + no + ", orderno=" + orderno + ", product_no=" + product_no + ", productqtt=" + productqtt
				+ ", total_price=" + total_price + ", purchasetime=" + purchasetime + "]";
	}
	
}
