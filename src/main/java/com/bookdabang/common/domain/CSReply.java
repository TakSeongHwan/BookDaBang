package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class CSReply {
	private int replyNo; 
	private String replier; 
	private String contents; 
	private Timestamp replyDate; 
	private int cs_postNo;
	public CSReply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CSReply(int replyNo, String replier, String contents, Timestamp replyDate, int cs_postNo) {
		super();
		this.replyNo = replyNo;
		this.replier = replier;
		this.contents = contents;
		this.replyDate = replyDate;
		this.cs_postNo = cs_postNo;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplier() {
		return replier;
	}
	public void setReplier(String replier) {
		this.replier = replier;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Timestamp replyDate) {
		this.replyDate = replyDate;
	}
	public int getCs_postNo() {
		return cs_postNo;
	}
	public void setCs_postNo(int cs_postNo) {
		this.cs_postNo = cs_postNo;
	}
	@Override
	public String toString() {
		return "CS_Reply [replyNo=" + replyNo + ", replier=" + replier + ", contents=" + contents + ", replyDate="
				+ replyDate + ", cs_postNo=" + cs_postNo + "]";
	}
	
}
