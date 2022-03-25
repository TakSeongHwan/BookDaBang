package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class FreeBoardComment {
	private int boardno; 
	private String commentwriter; 
	private Timestamp commentdate; 
	private String commentcontent; 
	private int commentno; 
	private int ref; 
	private int step; 
	private int reforder;
	
	public FreeBoardComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FreeBoardComment(int boardno, String commentwriter, Timestamp commentdate, String commentcontent,
			int commentno, int ref, int step, int reforder) {
		super();
		this.boardno = boardno;
		this.commentwriter = commentwriter;
		this.commentdate = commentdate;
		this.commentcontent = commentcontent;
		this.commentno = commentno;
		this.ref = ref;
		this.step = step;
		this.reforder = reforder;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getCommentwriter() {
		return commentwriter;
	}
	public void setCommentwriter(String commentwriter) {
		this.commentwriter = commentwriter;
	}
	public Timestamp getCommentdate() {
		return commentdate;
	}
	public void setCommentdate(Timestamp commentdate) {
		this.commentdate = commentdate;
	}
	public String getCommentcontent() {
		return commentcontent;
	}
	public void setCommentcontent(String commentcontent) {
		this.commentcontent = commentcontent;
	}
	public int getCommentno() {
		return commentno;
	}
	public void setCommentno(int commentno) {
		this.commentno = commentno;
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
		return "FreeBoardComment [boardno=" + boardno + ", commentwriter=" + commentwriter + ", commentdate="
				+ commentdate + ", commentcontent=" + commentcontent + ", commentno=" + commentno + ", ref=" + ref
				+ ", step=" + step + ", reforder=" + reforder + "]";
	}
	
}
