package com.bookdabang.cyh.domain;

public class ProdInfo {
	public String title = "";
	public String author = "";
	public String publisher = "";
	public String pubDate = "";
	public String description = "";

	public ProdInfo(String author, String publisher, String pubDate, String description) {
		super();
		this.author = author;
		this.publisher = publisher;
		this.pubDate = pubDate;
		this.description = description;
	}

	public ProdInfo() {
		super();
	}

	@Override
	public String toString() {
		return "ProdInfo [author=" + author + ", publisher=" + publisher + ", pubDate=" + pubDate + ", description="
				+ description + "]";
	}

}
