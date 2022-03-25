package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class RefundReply {
	private int replyNo; 
	private int refundNo; 
	private String content; 
	private String userId; 
	private Timestamp replyDate; 
	private int ref; 
	private int step; 
	private int reforder;
	public RefundReply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RefundReply(int replyNo, int refundNo, String content, String userId, Timestamp replyDate, int ref, int step,
			int reforder) {
		super();
		this.replyNo = replyNo;
		this.refundNo = refundNo;
		this.content = content;
		this.userId = userId;
		this.replyDate = replyDate;
		this.ref = ref;
		this.step = step;
		this.reforder = reforder;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getRefundNo() {
		return refundNo;
	}
	public void setRefundNo(int refundNo) {
		this.refundNo = refundNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Timestamp getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Timestamp replyDate) {
		this.replyDate = replyDate;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getReforder() {
		return reforder;
	}
	public void setReforder(int reforder) {
		this.reforder = reforder;
	}
	@Override
	public String toString() {
		return "RefundReply [replyNo=" + replyNo + ", refundNo=" + refundNo + ", content=" + content + ", userId="
				+ userId + ", replyDate=" + replyDate + ", ref=" + ref + ", step=" + step + ", reforder=" + reforder
				+ "]";
	}
	
}
