package com.bookdabang.lhs.domain;

import java.sql.Timestamp;

public class SalesDataWithDate {
private int totalSales;
private String date;
public SalesDataWithDate() {
	super();
}
public SalesDataWithDate(int totalSales, String date) {
	super();
	this.totalSales = totalSales;
	this.date = date;
}
public int getTotalSales() {
	return totalSales;
}
public void setTotalSales(int totalSales) {
	this.totalSales = totalSales;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
@Override
public String toString() {
	return "SalesDataWithDate [totalSales=" + totalSales + ", date=" + date + "]";
}


}
