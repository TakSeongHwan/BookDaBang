package com.bookdabang.common.domain;

public class Recommend {
	private String userId; 
	private int freeboardNo; 
	private int reviewNo;
	public Recommend() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Recommend(String userId, int freeboardNo, int reviewNo) {
		super();
		this.userId = userId;
		this.freeboardNo = freeboardNo;
		this.reviewNo = reviewNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getFreeboardNo() {
		return freeboardNo;
	}
	public void setFreeboardNo(int freeboardNo) {
		this.freeboardNo = freeboardNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	@Override
	public String toString() {
		return "Recommend [userId=" + userId + ", freeboardNo=" + freeboardNo + ", reviewNo=" + reviewNo + "]";
	}
	
}
