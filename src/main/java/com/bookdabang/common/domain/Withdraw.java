package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class Withdraw {
	private String userId; 
	private String why; 
	private Timestamp withdrawWhen;
	public Withdraw() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Withdraw(String userId, String why, Timestamp withdrawWhen) {
		super();
		this.userId = userId;
		this.why = why;
		this.withdrawWhen = withdrawWhen;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getWhy() {
		return why;
	}
	public void setWhy(String why) {
		this.why = why;
	}
	public Timestamp getWithdrawWhen() {
		return withdrawWhen;
	}
	public void setWithdrawWhen(Timestamp withdrawWhen) {
		this.withdrawWhen = withdrawWhen;
	}
	@Override
	public String toString() {
		return "Withdraw [userId=" + userId + ", why=" + why + ", withdrawWhen=" + withdrawWhen + "]";
	}
	
}
