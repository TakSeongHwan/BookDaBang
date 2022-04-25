package com.bookdabang.common.domain;

public class RecommendVO {
	private String userId; 
	private int freeboardNo; 
	private int reviewNo;
	private int change;
	
	public RecommendVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RecommendVO(String userId, int freeboardNo, int reviewNo, int change) {
		super();
		this.userId = userId;
		this.freeboardNo = freeboardNo;
		this.reviewNo = reviewNo;
		this.change = change;
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

	public int getChange() {
		return change;
	}

	public void setChange(int change) {
		this.change = change;
	}

	@Override
	public String toString() {
		return "RecommendVO [userId=" + userId + ", freeboardNo=" + freeboardNo + ", reviewNo=" + reviewNo + ", change="
				+ change + "]";
	}
	
}
