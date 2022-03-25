package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class Refund {
	private int refundNo; 
	private int orderNo; 
	private String userId; 
	private String productPhoto; 
	private String comment; 
	private Timestamp refundDate; 
	private String isRefund; 
	private Timestamp refundProcessdate; 
	private int refundReason; 
	private String orderPwd;
	public Refund() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Refund(int refundNo, int orderNo, String userId, String productPhoto, String comment, Timestamp refundDate,
			String isRefund, Timestamp refundProcessdate, int refundReason, String orderPwd) {
		super();
		this.refundNo = refundNo;
		this.orderNo = orderNo;
		this.userId = userId;
		this.productPhoto = productPhoto;
		this.comment = comment;
		this.refundDate = refundDate;
		this.isRefund = isRefund;
		this.refundProcessdate = refundProcessdate;
		this.refundReason = refundReason;
		this.orderPwd = orderPwd;
	}
	public int getRefundNo() {
		return refundNo;
	}
	public void setRefundNo(int refundNo) {
		this.refundNo = refundNo;
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
	public String getProductPhoto() {
		return productPhoto;
	}
	public void setProductPhoto(String productPhoto) {
		this.productPhoto = productPhoto;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Timestamp getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(Timestamp refundDate) {
		this.refundDate = refundDate;
	}
	public String getIsRefund() {
		return isRefund;
	}
	public void setIsRefund(String isRefund) {
		this.isRefund = isRefund;
	}
	public Timestamp getRefundProcessdate() {
		return refundProcessdate;
	}
	public void setRefundProcessdate(Timestamp refundProcessdate) {
		this.refundProcessdate = refundProcessdate;
	}
	public int getRefundReason() {
		return refundReason;
	}
	public void setRefundReason(int refundReason) {
		this.refundReason = refundReason;
	}
	public String getOrderPwd() {
		return orderPwd;
	}
	public void setOrderPwd(String orderPwd) {
		this.orderPwd = orderPwd;
	}
	@Override
	public String toString() {
		return "Refund [refundNo=" + refundNo + ", orderNo=" + orderNo + ", userId=" + userId + ", productPhoto="
				+ productPhoto + ", comment=" + comment + ", refundDate=" + refundDate + ", isRefund=" + isRefund
				+ ", refundProcessdate=" + refundProcessdate + ", refundReason=" + refundReason + ", orderPwd="
				+ orderPwd + "]";
	}
	
}
