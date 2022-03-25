package com.bookdabang.common.domain;

public class CSCategory {
	private int categoryCode; 
	private String categoryName;
	
	public CSCategory() {
		super();
	}

	public CSCategory(int categoryCode, String categoryName) {
		super();
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
	}
	
	public int getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	@Override
	public String toString() {
		return "CS_Category [categoryCode=" + categoryCode + ", categoryName=" + categoryName + "]";
	}
	
}
