package com.bookdabang.lbr.domain;

public class ReportArray {

	private String status;

	public ReportArray() {
		super();
	}

	public ReportArray(String status) {
		super();
		this.status = status;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ReportArray [status=" + status + "]";
	}
	
	
	
	
}
