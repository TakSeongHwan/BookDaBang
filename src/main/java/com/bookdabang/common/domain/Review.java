package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class Review {
	private int reviewNo; 
	private String title; 
	private String writer; 
	private Timestamp writedate; 
	private Timestamp content; 
	private int grade; 
	private int recommendNum; 
	private int productNo;
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Review(int reviewNo, String title, String writer, Timestamp writedate, Timestamp content, int grade,
			int recommendNum, int productNo) {
		super();
		this.reviewNo = reviewNo;
		this.title = title;
		this.writer = writer;
		this.writedate = writedate;
		this.content = content;
		this.grade = grade;
		this.recommendNum = recommendNum;
		this.productNo = productNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getWritedate() {
		return writedate;
	}
	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}
	public Timestamp getContent() {
		return content;
	}
	public void setContent(Timestamp content) {
		this.content = content;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getRecommendNum() {
		return recommendNum;
	}
	public void setRecommendNum(int recommendNum) {
		this.recommendNum = recommendNum;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", title=" + title + ", writer=" + writer + ", writedate=" + writedate
				+ ", content=" + content + ", grade=" + grade + ", recommendNum=" + recommendNum + ", productNo="
				+ productNo + "]";
	}
	
}
