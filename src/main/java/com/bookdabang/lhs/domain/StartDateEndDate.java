package com.bookdabang.lhs.domain;

import java.util.Date;

public class StartDateEndDate {
	private Date startDate;
	private Date endDate;
	public StartDateEndDate() {
		super();
	}
	public StartDateEndDate(Date startDate, Date endDate) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return "StartDateEndDate [startDate=" + startDate + ", endDate=" + endDate + "]";
	}
	
	
}
