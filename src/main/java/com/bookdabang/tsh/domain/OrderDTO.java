package com.bookdabang.tsh.domain;

public class OrderDTO {
	private int orderNo;
	private String userId;
	private String orderPwd;
	public OrderDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderDTO(int orderNo, String userId, String orderPwd) {
		super();
		this.orderNo = orderNo;
		this.userId = userId;
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
	public String getOrderPwd() {
		return orderPwd;
	}
	public void setOrderPwd(String orderPwd) {
		this.orderPwd = orderPwd;
	}
	@Override
	public String toString() {
		return "OrderDTO [orderNo=" + orderNo + ", userId=" + userId + ", orderPwd=" + orderPwd + "]";
	}
	
}
