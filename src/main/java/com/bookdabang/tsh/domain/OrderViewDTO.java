package com.bookdabang.tsh.domain;

import java.sql.Timestamp;

public class OrderViewDTO {
	private int orderNo;
	private String title;
	private String cover;
	private int productNo;
	private int orderState_code;
	private int productQtt;
	private int price;
	private String confirm;
	private Timestamp orderDate;
	private Timestamp releaseDate;
	public OrderViewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderViewDTO(int orderNo, String title, String cover, int productNo, int orderState_code, int productQtt,
			int price, String confirm, Timestamp orderDate, Timestamp releaseDate) {
		super();
		this.orderNo = orderNo;
		this.title = title;
		this.cover = cover;
		this.productNo = productNo;
		this.orderState_code = orderState_code;
		this.productQtt = productQtt;
		this.price = price;
		this.confirm = confirm;
		this.orderDate = orderDate;
		this.releaseDate = releaseDate;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getOrderState_code() {
		return orderState_code;
	}
	public void setOrderState_code(int orderState_code) {
		this.orderState_code = orderState_code;
	}
	public int getProductQtt() {
		return productQtt;
	}
	public void setProductQtt(int productQtt) {
		this.productQtt = productQtt;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public Timestamp getReleaseDate() {
		return releaseDate;
	}
	public void setReleaseDate(Timestamp releaseDate) {
		this.releaseDate = releaseDate;
	}
	@Override
	public String toString() {
		return "OrderViewDTO [orderNo=" + orderNo + ", title=" + title + ", cover=" + cover + ", productNo=" + productNo
				+ ", orderState_code=" + orderState_code + ", productQtt=" + productQtt + ", price=" + price
				+ ", confirm=" + confirm + ", orderDate=" + orderDate + ", releaseDate=" + releaseDate + "]";
	}
	
	
	
	
}
