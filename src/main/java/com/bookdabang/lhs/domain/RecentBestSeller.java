package com.bookdabang.lhs.domain;

public class RecentBestSeller {

	private String category_name;
	private String title;
	private String cover;
	private int totalSalesCount;
	public RecentBestSeller() {
		super();
	}
	public RecentBestSeller(String category_name, String title, String cover, int totalSalesCount) {
		super();
		this.category_name = category_name;
		this.title = title;
		this.cover = cover;
		this.totalSalesCount = totalSalesCount;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public int getTotalSalesCount() {
		return totalSalesCount;
	}
	public void setTotalSalesCount(int totalSalesCount) {
		this.totalSalesCount = totalSalesCount;
	}
	@Override
	public String toString() {
		return "RecentBestSeller [category_name=" + category_name + ", title=" + title + ", cover=" + cover
				+ ", totalSalesCount=" + totalSalesCount + "]";
	}
	
	
}
