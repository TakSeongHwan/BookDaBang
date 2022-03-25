package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class ReviewComment {
	private int commentNo; 
	private String commenter; 
	private Timestamp writeDate; 
	private String comment; 
	private int reviewNo; 
	private int ref; 
	private int step; 
	private int reforder;
	public ReviewComment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReviewComment(int commentNo, String commenter, Timestamp writeDate, String comment, int reviewNo, int ref,
			int step, int reforder) {
		super();
		this.commentNo = commentNo;
		this.commenter = commenter;
		this.writeDate = writeDate;
		this.comment = comment;
		this.reviewNo = reviewNo;
		this.ref = ref;
		this.step = step;
		this.reforder = reforder;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public String getCommenter() {
		return commenter;
	}
	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
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
		return "ReviewComment [commentNo=" + commentNo + ", commenter=" + commenter + ", writeDate=" + writeDate
				+ ", comment=" + comment + ", reviewNo=" + reviewNo + ", ref=" + ref + ", step=" + step + ", reforder="
				+ reforder + "]";
	}
	
}
