package com.bookdabang.common.domain;



public class ReportBoard   {
	private int boardno; 
	private String reportuser; 
	private String why; 
	private int reportno; 
	private String reportstatus;
	public ReportBoard() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReportBoard(int boardno, String reportuser, String why, int reportno, String reportstatus) {
		super();
		this.boardno = boardno;
		this.reportuser = reportuser;
		this.why = why;
		this.reportno = reportno;
		this.reportstatus = reportstatus;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getReportuser() {
		return reportuser;
	}
	public void setReportuser(String reportuser) {
		this.reportuser = reportuser;
	}
	public String getWhy() {
		return why;
	}
	public void setWhy(String why) {
		this.why = why;
	}
	public int getReportno() {
		return reportno;
	}
	public void setReportno(int reportno) {
		this.reportno = reportno;
	}
	public String getReportstatus() {
		return reportstatus;
	}
	public void setReportstatus(String reportstatus) {
		this.reportstatus = reportstatus;
	}
	@Override
	public String toString() {
		return "ReportBoard [boardno=" + boardno + ", reportuser=" + reportuser + ", why=" + why + ", reportno="
				+ reportno + ", reportstatus=" + reportstatus + "]";
	}
	
}
