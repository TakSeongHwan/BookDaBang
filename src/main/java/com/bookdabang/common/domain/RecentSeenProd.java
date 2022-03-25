package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class RecentSeenProd {
	private String userId; 
	private int lastSeenProd; 
	private Timestamp lastSeenDate;
	public RecentSeenProd() {
		super();
		// TODO Auto-generated constructor stub
	}
	public RecentSeenProd(String userId, int lastSeenProd, Timestamp lastSeenDate) {
		super();
		this.userId = userId;
		this.lastSeenProd = lastSeenProd;
		this.lastSeenDate = lastSeenDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getLastSeenProd() {
		return lastSeenProd;
	}
	public void setLastSeenProd(int lastSeenProd) {
		this.lastSeenProd = lastSeenProd;
	}
	public Timestamp getLastSeenDate() {
		return lastSeenDate;
	}
	public void setLastSeenDate(Timestamp lastSeenDate) {
		this.lastSeenDate = lastSeenDate;
	}
	@Override
	public String toString() {
		return "RecentSeenProd [userId=" + userId + ", lastSeenProd=" + lastSeenProd + ", lastSeenDate=" + lastSeenDate
				+ "]";
	}
	
}
