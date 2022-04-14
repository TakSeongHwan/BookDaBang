package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class RecentSeenProd {
	private String userId; 
	private int lastSeenProd; 
	private String title;
	private String cover;
	private Timestamp lastSeenDate;
	
	public RecentSeenProd() {
		super();
	}
	
	public RecentSeenProd(String userId, int lastSeenProd, String title, String cover, Timestamp lastSeenDate) {
		super();
		this.userId = userId;
		this.lastSeenProd = lastSeenProd;
		this.title = title;
		this.cover = cover;
		this.lastSeenDate = lastSeenDate;
	}
	
	public RecentSeenProd(String userId, int lastSeenProd, Timestamp lastSeenDate) {
		super();
		this.userId = userId;
		this.lastSeenProd = lastSeenProd;
		this.title = title;
		this.cover = cover;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public Timestamp getLastSeenDate() {
		return lastSeenDate;
	}

	public void setLastSeenDate(Timestamp lastSeenDate) {
		this.lastSeenDate = lastSeenDate;
	}

	@Override
	public String toString() {
		return "RecentSeenProd [userId=" + userId + ", lastSeenProd=" + lastSeenProd + ", title=" + title + ", cover="
				+ cover + ", lastSeenDate=" + lastSeenDate + "]";
	}
	

	
}
