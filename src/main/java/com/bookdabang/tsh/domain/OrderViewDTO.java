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
	private int refundNo;
	public OrderViewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderViewDTO(int orderNo, String title, String cover, int productNo, int orderState_code, int productQtt,
			int price, String confirm, Timestamp orderDate, Timestamp releaseDate, int refundNo) {
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
		this.refundNo = refundNo;
	}
	public final int getOrderNo() {
		return orderNo;
	}
	public final void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public final String getTitle() {
		return title;
	}
	public final void setTitle(String title) {
		this.title = title;
	}
	public final String getCover() {
		return cover;
	}
	public final void setCover(String cover) {
		this.cover = cover;
	}
	public final int getProductNo() {
		return productNo;
	}
	public final void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public final int getOrderState_code() {
		return orderState_code;
	}
	public final void setOrderState_code(int orderState_code) {
		this.orderState_code = orderState_code;
	}
	public final int getProductQtt() {
		return productQtt;
	}
	public final void setProductQtt(int productQtt) {
		this.productQtt = productQtt;
	}
	public final int getPrice() {
		return price;
	}
	public final void setPrice(int price) {
		this.price = price;
	}
	public final String getConfirm() {
		return confirm;
	}
	public final void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public final Timestamp getOrderDate() {
		return orderDate;
	}
	public final void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public final Timestamp getReleaseDate() {
		return releaseDate;
	}
	public final void setReleaseDate(Timestamp releaseDate) {
		this.releaseDate = releaseDate;
	}
	public final int getRefundNo() {
		return refundNo;
	}
	public final void setRefundNo(int refundNo) {
		this.refundNo = refundNo;
	}
	@Override
	public String toString() {
		return "OrderViewDTO [orderNo=" + orderNo + ", title=" + title + ", cover=" + cover + ", productNo=" + productNo
				+ ", orderState_code=" + orderState_code + ", productQtt=" + productQtt + ", price=" + price
				+ ", confirm=" + confirm + ", orderDate=" + orderDate + ", releaseDate=" + releaseDate + ", refundNo="
				+ refundNo + "]";
	}
	
}
