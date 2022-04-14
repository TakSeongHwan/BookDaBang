package com.bookdabang.cyh.domain;

public class ProdQnADTO {
	private String isbn;
	private String writer;
	private String content;
	private String pwd;
	private int ref;

	public ProdQnADTO(String isbn, String writer, String content, String pwd, int ref) {
		super();
		this.isbn = isbn;
		this.writer = writer;
		this.content = content;
		this.pwd = pwd;
		this.ref = ref;
	}
	
	

	public ProdQnADTO() {
		super();
	}



	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	@Override
	public String toString() {
		return "ProdQnADTO [isbn=" + isbn + ", writer=" + writer + ", content=" + content + ", pwd=" + pwd + ", ref="
				+ ref + "]";
	}

}
