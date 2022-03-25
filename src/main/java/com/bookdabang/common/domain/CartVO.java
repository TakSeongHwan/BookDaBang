package com.bookdabang.common.domain;

public class CartVO {

	private int cartNo; 
	private String userId;
	private String ipaddr;
	private int productNo; 
	private int productQtt;
	public CartVO() {}
	public CartVO(int cartNo, String userId, String ipaddr, int productNo, int productQtt) {
		super();
		this.cartNo = cartNo;
		this.userId = userId;
		this.ipaddr = ipaddr;
		this.productNo = productNo;
		this.productQtt = productQtt;
	}
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getProductQtt() {
		return productQtt;
	}
	public void setProductQtt(int productQtt) {
		this.productQtt = productQtt;
	}
	@Override
	public String toString() {
		return "CartVO [cartNo=" + cartNo + ", userId=" + userId + ", ipaddr=" + ipaddr + ", productNo=" + productNo
				+ ", productQtt=" + productQtt + "]";
	}
	
}
