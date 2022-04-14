package com.bookdabang.lhs.domain;

import java.sql.Timestamp;

public class VisitorCountWithDateFormat {
	private int monthSort;
	private int visitor;
	public VisitorCountWithDateFormat() {
		super();
	}
	public VisitorCountWithDateFormat(int monthSort, int visitor) {
		super();
		this.monthSort = monthSort;
		this.visitor = visitor;
	}
	public int getmonthSort() {
		return monthSort;
	}
	public void setmonthSort(int monthSort) {
		this.monthSort = monthSort;
	}
	public int getVisitor() {
		return visitor;
	}
	public void setVisitor(int visitor) {
		this.visitor = visitor;
	}
	@Override
	public String toString() {
		return "VisitorCountWithDateFormat [monthSort=" + monthSort + ", visitor=" + visitor + "]";
	}
	
}	
