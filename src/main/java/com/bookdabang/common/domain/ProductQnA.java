package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class ProductQnA {
	private int question_no; 
	private int product_no; 
	private String writer; 
	private Timestamp write_date; 
	private String content; 
	private String answer_status; 
	private String pwd; 
	private int ref; 
	private int level; 
	private int ref_order;
	public ProductQnA() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ProductQnA(int question_no, int product_no, String writer, Timestamp write_date, String content,
			String answer_status, String pwd, int ref, int level, int ref_order) {
		super();
		this.question_no = question_no;
		this.product_no = product_no;
		this.writer = writer;
		this.write_date = write_date;
		this.content = content;
		this.answer_status = answer_status;
		this.pwd = pwd;
		this.ref = ref;
		this.level = level;
		this.ref_order = ref_order;
	}
	public int getQuestion_no() {
		return question_no;
	}
	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAnswer_status() {
		return answer_status;
	}
	public void setAnswer_status(String answer_status) {
		this.answer_status = answer_status;
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
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getRef_order() {
		return ref_order;
	}
	public void setRef_order(int ref_order) {
		this.ref_order = ref_order;
	}
	@Override
	public String toString() {
		return "ProductQnA [question_no=" + question_no + ", product_no=" + product_no + ", writer=" + writer
				+ ", write_date=" + write_date + ", content=" + content + ", answer_status=" + answer_status + ", pwd="
				+ pwd + ", ref=" + ref + ", level=" + level + ", ref_order=" + ref_order + "]";
	}
	
}
