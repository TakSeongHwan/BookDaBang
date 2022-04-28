package com.bookdabang.lhs.domain;

public class CategoryTotalSales {
private String category_name;
private int totalSales;
public CategoryTotalSales() {
	super();
}
public CategoryTotalSales(String category_name, int totalSales) {
	super();
	this.category_name = category_name;
	this.totalSales = totalSales;
}
public String getCategory_name() {
	return category_name;
}
public void setCategory_name(String category_name) {
	this.category_name = category_name;
}
public int getTotalSales() {
	return totalSales;
}
public void setTotalSales(int totalSales) {
	this.totalSales = totalSales;
}
@Override
public String toString() {
	return "CategoryTotalSales [category_name=" + category_name + ", totalSales=" + totalSales + "]";
}



}
