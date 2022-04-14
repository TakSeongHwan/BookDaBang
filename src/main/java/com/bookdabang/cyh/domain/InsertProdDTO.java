package com.bookdabang.cyh.domain;

import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

public class InsertProdDTO {

	private String title;
	private String author;
	private int price;
	private int sell_price;
	private String publisher;
	private int category_code;
	private String description;
	private String pub_date;
	private int stock;
	private String end_date;
	private String display_status;
	private String sales_status;
	private String cover;
	private String detail_description;
	private String index;
	private String inside_book;
	private String author_introduce;
	private String pisOffdiscription;
	private String isbn;

	public InsertProdDTO(String title, String author, int price, int sell_price, String publisher, int category_code,
			String description, String pub_date, int stock, String end_date, String display_status, String sales_status,
			String cover, String detail_description, String index, String inside_book, String author_introduce,
			String pisOffdiscription, String isbn) {
		super();
		this.title = title;
		this.author = author;
		this.price = price;
		this.sell_price = sell_price;
		this.publisher = publisher;
		this.category_code = category_code;
		this.description = description;
		this.pub_date = pub_date;
		this.stock = stock;
		this.end_date = end_date;
		this.display_status = display_status;
		this.sales_status = sales_status;
		this.cover = cover;
		this.detail_description = detail_description;
		this.index = index;
		this.inside_book = inside_book;
		this.author_introduce = author_introduce;
		this.pisOffdiscription = pisOffdiscription;
		this.isbn = isbn;
	}

	public InsertProdDTO() {
		super();
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

	public String getPub_date() {
		return pub_date;
	}

	public void setPub_date(String pub_date) {
		this.pub_date = pub_date;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getDisplay_status() {
		return display_status;
	}

	public void setDisplay_status(String display_status) {
		this.display_status = display_status;
	}

	public String getSales_status() {
		return sales_status;
	}

	public void setSales_status(String sales_status) {
		this.sales_status = sales_status;
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

	@Override
	public String toString() {
		return "InsertProdDTO [title=" + title + ", author=" + author + ", price=" + price + ", sell_price="
				+ sell_price + ", publisher=" + publisher + ", category_code=" + category_code + ", description="
				+ description + ", pub_date=" + pub_date + ", stock=" + stock + ", end_date=" + end_date
				+ ", display_status=" + display_status + ", sales_status=" + sales_status + ", cover=" + cover
				+ ", detail_description=" + detail_description + ", index=" + index + ", inside_book=" + inside_book
				+ ", author_introduce=" + author_introduce + ", pisOffdiscription=" + pisOffdiscription + ", isbn="
				+ isbn + "]";
	}

}
