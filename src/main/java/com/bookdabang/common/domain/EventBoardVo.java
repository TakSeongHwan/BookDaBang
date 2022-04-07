package com.bookdabang.common.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class EventBoardVO {
	private int boardno;
	private String writer;
	private Timestamp date;
	private int readcount;
	private Date duration;
	private String title;
	private String content;
	
	public EventBoardVO() { }
	
	public EventBoardVO(int boardno, String writer, Timestamp date, int readcount, Date duration, String title,
			String content) {
		super();
		this.boardno = boardno;
		this.writer = writer;
		this.date = date;
		this.readcount = readcount;
		this.duration = duration;
		this.title = title;
		this.content = content;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public Date getDuration() {
		return duration;
	}

	public void setDuration(Date duration) {
		this.duration = duration;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "EventBoardVo [boardno=" + boardno + ", writer=" + writer + ", date=" + date + ", readcount=" + readcount
				+ ", duration=" + duration + ", title=" + title + ", content=" + content + "]";
	}
	
	
	
	
}
