package com.bookdabang.lhs.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class SalesChartDetail {
	private String searchType;
	private Date startDate;
	private Date endDate;
	public SalesChartDetail() {
		super();
	}
	public SalesChartDetail(String searchType, Date startDate, Date endDate) {
		super();
		this.searchType = searchType;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
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
		return "SalesChartDetail [searchType=" + searchType + ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}
	
}
