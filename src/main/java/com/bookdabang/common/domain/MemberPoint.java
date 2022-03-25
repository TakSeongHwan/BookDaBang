package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class MemberPoint {
	private String userId; 
	private int point ; 
	private Timestamp pointWhen; 
	private String pointWhy; 
	private String recommend;
	
	public MemberPoint() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberPoint(String userId, int point, Timestamp pointWhen, String pointWhy, String recommend) {
		super();
		this.userId = userId;
		this.point = point;
		this.pointWhen = pointWhen;
		this.pointWhy = pointWhy;
		this.recommend = recommend;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Timestamp getPointWhen() {
		return pointWhen;
	}
	public void setPointWhen(Timestamp pointWhen) {
		this.pointWhen = pointWhen;
	}
	public String getPointWhy() {
		return pointWhy;
	}
	public void setPointWhy(String pointWhy) {
		this.pointWhy = pointWhy;
	}
	public String getRecommend() {
		return recommend;
	}
	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}
	@Override
	public String toString() {
		return "MemberPoint [userId=" + userId + ", point=" + point + ", pointWhen=" + pointWhen + ", pointWhy="
				+ pointWhy + ", recommend=" + recommend + "]";
	}
	
}
