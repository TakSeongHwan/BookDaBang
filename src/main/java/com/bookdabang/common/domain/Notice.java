package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class Notice {
	private int no; 
	private String title; 
	private String writer; 
	private Timestamp writedDate; 
	private String content; 
	private int viewCount; 
	private int reply; 
	private String image;
	
	public Notice() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Notice(int no, String title, String writer, Timestamp writedDate, String content, int viewCount, int reply,
			String image) {
		super();
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.writedDate = writedDate;
		this.content = content;
		this.viewCount = viewCount;
		this.reply = reply;
		this.image = image;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
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

	public Timestamp getWritedDate() {
		return writedDate;
	}

	public void setWritedDate(Timestamp writedDate) {
		this.writedDate = writedDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getReply() {
		return reply;
	}

	public void setReply(int reply) {
		this.reply = reply;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "Notice [no=" + no + ", title=" + title + ", writer=" + writer + ", writedDate=" + writedDate
				+ ", content=" + content + ", viewCount=" + viewCount + ", reply=" + reply + ", image=" + image + "]";
	}
	
	
}
