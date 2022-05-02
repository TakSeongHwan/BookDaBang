package com.bookdabang.lhs.domain;

import java.sql.Timestamp;

public class VisitorCountWithDateFormat {
	private String dateSort;
	private int visitor;
	public VisitorCountWithDateFormat() {
		super();
	}
	public VisitorCountWithDateFormat(String dateSort, int visitor) {
		super();
		this.dateSort = dateSort;
		this.visitor = visitor;
	}
	public String getDateSort() {
		return dateSort;
	}
	public void setDateSort(String dateSort) {
		this.dateSort = dateSort;
	}
	public int getVisitor() {
		return visitor;
	}
	public void setVisitor(int visitor) {
		this.visitor = visitor;
	}
	@Override
	public String toString() {
		return "VisitorCountWithDateFormat [dateSort=" + dateSort + ", visitor=" + visitor + "]";
	}
	
}	
