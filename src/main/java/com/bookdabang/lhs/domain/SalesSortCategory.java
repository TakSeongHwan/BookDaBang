package com.bookdabang.lhs.domain;

public class SalesSortCategory {
private int totalSalesCount;
private String category_name;
public SalesSortCategory() {
	super();
}
public SalesSortCategory(int totalSalesCount, String category_name) {
	super();
	this.totalSalesCount = totalSalesCount;
	this.category_name = category_name;
}
public int getTotalSalesCount() {
	return totalSalesCount;
}
public void setTotalSalesCount(int totalSalesCount) {
	this.totalSalesCount = totalSalesCount;
}
public String getCategory_name() {
	return category_name;
}
public void setCategory_name(String category_name) {
	this.category_name = category_name;
}
@Override
public String toString() {
	return "SalesSortCategory [totalSalesCount=" + totalSalesCount + ", category_name=" + category_name + "]";
}

}
