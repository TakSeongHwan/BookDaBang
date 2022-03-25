package com.bookdabang.common.domain;

public class RefundReason {
	private int code; 
	private String refundReason;
	public RefundReason() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RefundReason(int code, String refundReason) {
		super();
		this.code = code;
		this.refundReason = refundReason;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getRefundReason() {
		return refundReason;
	}
	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}
	@Override
	public String toString() {
		return "RefundReason [code=" + code + ", refundReason=" + refundReason + "]";
	}
	
}
