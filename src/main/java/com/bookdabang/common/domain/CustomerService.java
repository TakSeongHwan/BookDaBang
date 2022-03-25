package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class CustomerService {
	private int postNo; 
	private int categoryCode; 
	private String writer;
	private Timestamp postdate; 
	private String title; 
	private String status; 
	private String contents;
	
	public CustomerService() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CustomerService(int postNo, int categoryCode, String writer, Timestamp postdate, String title, String status,
			String contents) {
		super();
		this.postNo = postNo;
		this.categoryCode = categoryCode;
		this.writer = writer;
		this.postdate = postdate;
		this.title = title;
		this.status = status;
		this.contents = contents;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getPostdate() {
		return postdate;
	}
	public void setPostdate(Timestamp postdate) {
		this.postdate = postdate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "CustomerService [postNo=" + postNo + ", categoryCode=" + categoryCode + ", writer=" + writer
				+ ", postdate=" + postdate + ", title=" + title + ", status=" + status + ", contents=" + contents + "]";
	}
	
}
