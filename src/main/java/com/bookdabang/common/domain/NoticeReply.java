package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class NoticeReply {
	private int replyNo; 
	private int boardNo; 
	private String replyer; 
	private String replyContent; 
	private Timestamp replyDate; 
	private int ref; 
	private int step; 
	private int refOrder;
	public NoticeReply() {
		super();
		// TODO Auto-generated constructor stub
	}
	public NoticeReply(int replyNo, int boardNo, String replyer, String replyContent, Timestamp replyDate, int ref,
			int step, int refOrder) {
		super();
		this.replyNo = replyNo;
		this.boardNo = boardNo;
		this.replyer = replyer;
		this.replyContent = replyContent;
		this.replyDate = replyDate;
		this.ref = ref;
		this.step = step;
		this.refOrder = refOrder;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
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
	public int getRefOrder() {
		return refOrder;
	}
	public void setRefOrder(int refOrder) {
		this.refOrder = refOrder;
	}
	@Override
	public String toString() {
		return "NoticeReply [replyNo=" + replyNo + ", boardNo=" + boardNo + ", replyer=" + replyer + ", replyContent="
				+ replyContent + ", replyDate=" + replyDate + ", ref=" + ref + ", step=" + step + ", refOrder="
				+ refOrder + "]";
	}
	
}
