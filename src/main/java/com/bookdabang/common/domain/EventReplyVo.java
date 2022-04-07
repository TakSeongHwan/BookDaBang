package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class EventReplyVo {
	private int boardNo;
	private int replyNo;
	private String replywriter;
	private Timestamp replyDate;
	private String content;
	private int ref;
	private int step;
	private int reforder;
	
	EventReplyVo(){}

	public EventReplyVo(int boardNo, int replyNo, String replywriter, Timestamp replyDate, String content, int ref,
			int step, int reforder) {
		super();
		this.boardNo = boardNo;
		this.replyNo = replyNo;
		this.replywriter = replywriter;
		this.replyDate = replyDate;
		this.content = content;
		this.ref = ref;
		this.step = step;
		this.reforder = reforder;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getReplywriter() {
		return replywriter;
	}

	public void setReplywriter(String replywriter) {
		this.replywriter = replywriter;
	}

	public Timestamp getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Timestamp replyDate) {
		this.replyDate = replyDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
		return "EventReplyVO [boardNo=" + boardNo + ", replyNo=" + replyNo + ", replywriter=" + replywriter
				+ ", replyDate=" + replyDate + ", content=" + content + ", ref=" + ref + ", step=" + step
				+ ", reforder=" + reforder + "]";
	}
	
	
}
