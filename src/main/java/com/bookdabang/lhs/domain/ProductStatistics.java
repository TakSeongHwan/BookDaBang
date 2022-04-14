package com.bookdabang.lhs.domain;

public class ProductStatistics {
	private int product_no;
	private String category_name;
	private String title;
	private int salesCount;
	private int price;
	private int sell_price;
	private int stock;
	private int read_count;
	private String sales_status;
	private int reviewCount;
	public ProductStatistics() {
		super();
	}
	public ProductStatistics(int product_no, String category_name, String title, int salesCount, int price,
			int sell_price, int stock, int read_count, String sales_status, int reviewCount) {
		super();
		this.product_no = product_no;
		this.category_name = category_name;
		this.title = title;
		this.salesCount = salesCount;
		this.price = price;
		this.sell_price = sell_price;
		this.stock = stock;
		this.read_count = read_count;
		this.sales_status = sales_status;
		this.reviewCount = reviewCount;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
	public int getSalesCount() {
		return salesCount;
	}
	public void setSalesCount(int salesCount) {
		this.salesCount = salesCount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSell_price() {
		return sell_price;
	}
	public void setSell_price(int sell_price) {
		this.sell_price = sell_price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getRead_count() {
		return read_count;
	}
	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}
	public String getSales_status() {
		return sales_status;
	}
	public void setSales_status(String sales_status) {
		this.sales_status = sales_status;
	}
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	@Override
	public String toString() {
		return "ProductStatistics [product_no=" + product_no + ", category_name=" + category_name + ", title=" + title
				+ ", salesCount=" + salesCount + ", price=" + price + ", sell_price=" + sell_price + ", stock=" + stock
				+ ", read_count=" + read_count + ", sales_status=" + sales_status + ", reviewCount=" + reviewCount
				+ "]";
	}
	
}
