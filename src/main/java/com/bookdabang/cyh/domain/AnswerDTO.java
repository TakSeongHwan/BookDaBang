package com.bookdabang.cyh.domain;

public class AnswerDTO {
	private int question_no;
	private String product_no;
	private String content;
	private String writer;
	private String pwd;

	public AnswerDTO(int question_no, String product_no, String content, String writer, String pwd) {
		super();
		this.question_no = question_no;
		this.product_no = product_no;
		this.content = content;
		this.writer = writer;
		this.pwd = pwd;
	}

	public AnswerDTO() {
		super();
	}

	public int getQuestion_no() {
		return question_no;
	}

	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Override
	public String toString() {
		return "AnswerDTO [question_no=" + question_no + ", product_no=" + product_no + ", content=" + content
				+ ", writer=" + writer + ", pwd=" + pwd + "]";
	}

}
