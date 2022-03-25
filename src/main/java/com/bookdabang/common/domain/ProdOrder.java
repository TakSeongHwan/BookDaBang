package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class ProdOrder {
	private int orderNo; 
	private String userId; 
	private int productNo; 
	private int productQtt; 
	private int orderState_code; 
	private Timestamp orderDate; 
	private int addressNo; 
	private Timestamp releaseDate; 
	private String confirm; 
	private int price; 
	private String orderPwd;
	public ProdOrder() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProdOrder(int orderNo, String userId, int productNo, int productQtt, int orderState_code,
			Timestamp orderDate, int addressNo, Timestamp releaseDate, String confirm, int price, String orderPwd) {
		super();
		this.orderNo = orderNo;
		this.userId = userId;
		this.productNo = productNo;
		this.productQtt = productQtt;
		this.orderState_code = orderState_code;
		this.orderDate = orderDate;
		this.addressNo = addressNo;
		this.releaseDate = releaseDate;
		this.confirm = confirm;
		this.price = price;
		this.orderPwd = orderPwd;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public int getOrderState_code() {
		return orderState_code;
	}
	public void setOrderState_code(int orderState_code) {
		this.orderState_code = orderState_code;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public int getAddressNo() {
		return addressNo;
	}
	public void setAddressNo(int addressNo) {
		this.addressNo = addressNo;
	}
	public Timestamp getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Timestamp releaseDate) {
		this.releaseDate = releaseDate;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getOrderPwd() {
		return orderPwd;
	}
	public void setOrderPwd(String orderPwd) {
		this.orderPwd = orderPwd;
	}
	@Override
	public String toString() {
		return "ProdOrder [orderNo=" + orderNo + ", userId=" + userId + ", productNo=" + productNo + ", productQtt="
				+ productQtt + ", orderState_code=" + orderState_code + ", orderDate=" + orderDate + ", addressNo="
				+ addressNo + ", releaseDate=" + releaseDate + ", confirm=" + confirm + ", price=" + price
				+ ", orderPwd=" + orderPwd + "]";
	}
	
}
