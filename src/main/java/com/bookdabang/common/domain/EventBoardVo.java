package com.bookdabang.common.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class EventBoardVo {
	private int boardNo;
	private String writer;
	private Timestamp date;
	private int readcount;
	private Date eventStart;
	private Date eventEnd;
	private String title;
	private String content;
	private String mainImg;
	
	public EventBoardVo(){}


	public EventBoardVo(int boardNo, String writer, Timestamp date, int readcount, Date eventStart, Date eventEnd,
			String title, String content, String mainImg) {
		super();
		this.boardNo = boardNo;
		this.writer = writer;
		this.date = date;
		this.readcount = readcount;
		this.eventStart = eventStart;
		this.eventEnd = eventEnd;
		this.title = title;
		this.content = content;
		this.mainImg = mainImg;
	}


	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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

	

	public Date getEventStart() {
		return eventStart;
	}


	public void setEventStart(Date eventStart) {
		this.eventStart = eventStart;
	}


	public Date getEventEnd() {
		return eventEnd;
	}


	public void setEventEnd(Date eventEnd) {
		this.eventEnd = eventEnd;
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

	
	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}


	@Override
	public String toString() {
		return "EventBoardVO [boardNo=" + boardNo + ", writer=" + writer + ", date=" + date + ", readcount=" + readcount
				+ ", eventStart=" + eventStart + ", eventEnd=" + eventEnd + ", title=" + title + ", content=" + content
				+ ", mainImg=" + mainImg + "]";
	}



	
	
	
	
}
