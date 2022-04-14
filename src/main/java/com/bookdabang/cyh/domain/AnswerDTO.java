package com.bookdabang.cyh.domain;

public class AnswerDTO {
	private int question_no;
	private String product_no;
	private String content;

	public AnswerDTO(int question_no, String product_no, String content) {
		super();
		this.question_no = question_no;
		this.product_no = product_no;
		this.content = content;
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

	@Override
	public String toString() {
		return "AnswerDTO [question_no=" + question_no + ", product_no=" + product_no + ", content=" + content + "]";
	}

}
