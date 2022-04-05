package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class ProductVO {
	private int product_no;
	private String title;
	private String author;
	private int price;
	private int sell_price;
	private String publisher;
	private int category_code;
	private String description;
	private Timestamp pub_date;
	private int stock;
	private Timestamp rg_date;
	private Timestamp end_date;
	private Timestamp update_date;
	private String display_status;
	private int read_count;
	private String sales_status;
	private int sales_count;
	private String cover;
	private String detail_description;
	private String index;
	private String inside_book;
	private String author_introduce;
	private String pisOffdiscription;
	private String isbn;
	private String isbn13;

	public ProductVO() {
		super();
	}

	public ProductVO(int product_no, String title, String author, int price, int sell_price, String publisher,
			int category_code, String description, Timestamp pub_date, int stock, Timestamp rg_date, Timestamp end_date,
			Timestamp update_date, String display_status, int read_count, String sales_status, int sales_count,
			String cover, String detail_description, String index, String inside_book, String author_introduce,
			String pisOffdiscription, String isbn, String isbn13) {
		super();
		this.product_no = product_no;
		this.title = title;
		this.author = author;
		this.price = price;
		this.sell_price = sell_price;
		this.publisher = publisher;
		this.category_code = category_code;
		this.description = description;
		this.pub_date = pub_date;
		this.stock = stock;
		this.rg_date = rg_date;
		this.end_date = end_date;
		this.update_date = update_date;
		this.display_status = display_status;
		this.read_count = read_count;
		this.sales_status = sales_status;
		this.sales_count = sales_count;
		this.cover = cover;
		this.detail_description = detail_description;
		this.index = index;
		this.inside_book = inside_book;
		this.author_introduce = author_introduce;
		this.pisOffdiscription = pisOffdiscription;
		this.isbn = isbn;
		this.isbn13 = isbn13;
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

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public int getCategory_code() {
		return category_code;
	}

	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getPub_date() {
		return pub_date;
	}

	public void setPub_date(Timestamp pub_date) {
		this.pub_date = pub_date;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public Timestamp getRg_date() {
		return rg_date;
	}

	public void setRg_date(Timestamp rg_date) {
		this.rg_date = rg_date;
	}

	public Timestamp getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Timestamp end_date) {
		this.end_date = end_date;
	}

	public Timestamp getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}

	public String getDisplay_status() {
		return display_status;
	}

	public void setDisplay_status(String display_status) {
		this.display_status = display_status;
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

	public int getSales_count() {
		return sales_count;
	}

	public void setSales_count(int sales_count) {
		this.sales_count = sales_count;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getDetail_description() {
		return detail_description;
	}

	public void setDetail_description(String detail_description) {
		this.detail_description = detail_description;
	}

	public String getIndex() {
		return index;
	}

	public void setIndex(String index) {
		this.index = index;
	}

	public String getInside_book() {
		return inside_book;
	}

	public void setInside_book(String inside_book) {
		this.inside_book = inside_book;
	}

	public String getAuthor_introduce() {
		return author_introduce;
	}

	public void setAuthor_introduce(String author_introduce) {
		this.author_introduce = author_introduce;
	}

	public String getPisOffdiscription() {
		return pisOffdiscription;
	}

	public void setPisOffdiscription(String pisOffdiscription) {
		this.pisOffdiscription = pisOffdiscription;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getIsbn13() {
		return isbn13;
	}

	public void setIsbn13(String isbn13) {
		this.isbn13 = isbn13;
	}

	@Override
	public String toString() {
		return "ProductVO [product_no=" + product_no + ", title=" + title + ", author=" + author + ", price=" + price
				+ ", sell_price=" + sell_price + ", publisher=" + publisher + ", category_code=" + category_code
				+ ", description=" + description + ", pub_date=" + pub_date + ", stock=" + stock + ", rg_date="
				+ rg_date + ", end_date=" + end_date + ", update_date=" + update_date + ", display_status="
				+ display_status + ", read_count=" + read_count + ", sales_status=" + sales_status + ", sales_count="
				+ sales_count + ", cover=" + cover + ", detail_description=" + detail_description + ", index=" + index
				+ ", inside_book=" + inside_book + ", author_introduce=" + author_introduce + ", pisOffdiscription="
				+ pisOffdiscription + ", isbn=" + isbn + ", isbn13=" + isbn13 + "]";
	}


}
