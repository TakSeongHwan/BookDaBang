package com.bookdabang.lhs.domain;

public class ProductStatisticsAG {
	private int product_no;
	private String category_name;
	private String title;
	private String author;
	private int price;
	private int sell_price;
	private int salesCount;
	public ProductStatisticsAG() {
		super();
	}
	public ProductStatisticsAG(int product_no, String category_name, String title, String author, int price,
			int sell_price, int salesCount) {
		super();
		this.product_no = product_no;
		this.category_name = category_name;
		this.title = title;
		this.author = author;
		this.price = price;
		this.sell_price = sell_price;
		this.salesCount = salesCount;
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
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
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
	public int getSalesCount() {
		return salesCount;
	}
	public void setSalesCount(int salesCount) {
		this.salesCount = salesCount;
	}
	@Override
	public String toString() {
		return "ProductStatisticsAG [product_no=" + product_no + ", category_name=" + category_name + ", title=" + title
				+ ", author=" + author + ", price=" + price + ", sell_price=" + sell_price + ", salesCount="
				+ salesCount + "]";
	}
}
