package com.bookdabang.lhs.domain;


public class SalesDataDetail {
	private int product_no;
	private String title;
	private String author;
	private int price;
	private int sell_price;
	private int sall_count;
	private String category_name;
	private int age;
	private String gender;
	public SalesDataDetail() {
		super();
	}
	public SalesDataDetail(int product_no, String title, String author, int price, int sell_price, int sall_count,
			String category_name, int age, String gender) {
		super();
		this.product_no = product_no;
		this.title = title;
		this.author = author;
		this.price = price;
		this.sell_price = sell_price;
		this.sall_count = sall_count;
		this.category_name = category_name;
		this.age = age;
		this.gender = gender;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
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
	public int getSall_count() {
		return sall_count;
	}
	public void setSall_count(int sall_count) {
		this.sall_count = sall_count;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public int getage() {
		return age;
	}
	public void setage(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "SalesDataDetail [product_no=" + product_no + ", title=" + title + ", author=" + author + ", price="
				+ price + ", sell_price=" + sell_price + ", sall_count=" + sall_count + ", category_name="
				+ category_name + ", age=" + age + ", gender=" + gender + "]";
	}
	
}
