package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class PageView {
	private String ip_address; 
	private int freeboardNo; 
	private int noticeNo; 
	private int productNo; 
	private Timestamp accessDate;
	public PageView() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PageView(String ip_address, int freeboardNo, int noticeNo, int productNo, Timestamp accessDate) {
		super();
		this.ip_address = ip_address;
		this.freeboardNo = freeboardNo;
		this.noticeNo = noticeNo;
		this.productNo = productNo;
		this.accessDate = accessDate;
	}
	public String getIp_address() {
		return ip_address;
	}
	public void setIp_address(String ip_address) {
		this.ip_address = ip_address;
	}
	public int getFreeboardNo() {
		return freeboardNo;
	}
	public void setFreeboardNo(int freeboardNo) {
		this.freeboardNo = freeboardNo;
	}
	public int getNoticeNo() {
		return noticeNo;
	}
	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public Timestamp getAccessDate() {
		return accessDate;
	}
	public void setAccessDate(Timestamp accessDate) {
		this.accessDate = accessDate;
	}
	@Override
	public String toString() {
		return "PageView [ip_address=" + ip_address + ", freeboardNo=" + freeboardNo + ", noticeNo=" + noticeNo
				+ ", productNo=" + productNo + ", accessDate=" + accessDate + "]";
	}
	
}
