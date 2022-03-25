package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class FreeBoard {
	private int boardno;
	private String writer;
	private String title; 
	private String content ; 
	private int readcount;
	private String deleteyn; 
	private Timestamp date; 
	private Timestamp modifydate; 
	private int likecount;
	
	public FreeBoard() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FreeBoard(int boardno, String writer, String title, String content, int readcount, String deleteyn,
			Timestamp date, Timestamp modifydate, int likecount) {
		super();
		this.boardno = boardno;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.readcount = readcount;
		this.deleteyn = deleteyn;
		this.date = date;
		this.modifydate = modifydate;
		this.likecount = likecount;
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
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getDeleteyn() {
		return deleteyn;
	}
	public void setDeleteyn(String deleteyn) {
		this.deleteyn = deleteyn;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public Timestamp getModifydate() {
		return modifydate;
	}
	public void setModifydate(Timestamp modifydate) {
		this.modifydate = modifydate;
	}
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	@Override
	public String toString() {
		return "FreeBoard [boardno=" + boardno + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", readcount=" + readcount + ", deleteyn=" + deleteyn + ", date=" + date + ", modifydate="
				+ modifydate + ", likecount=" + likecount + "]";
	}
	
}
