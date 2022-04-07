package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class AttendanceVo {
	private String userId;
	private Timestamp date;
	private int continuity;
	private int reservePoint;
	private int point;
	public AttendanceVo() {}
	
	public AttendanceVo(String userId, Timestamp date, int continuity, int reservePoint, int point) {
		super();
		this.userId = userId;
		this.date = date;
		this.continuity = continuity;
		this.reservePoint = reservePoint;
		this.point = point;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public int getContinuity() {
		return continuity;
	}

	public void setContinuity(int continuity) {
		this.continuity = continuity;
	}

	public int getReservePoint() {
		return reservePoint;
	}

	public void setReservePoint(int reservePoint) {
		this.reservePoint = reservePoint;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	@Override
	public String toString() {
		return "AttendanceVo [userId=" + userId + ", date=" + date + ", continuity=" + continuity + ", reservePoint="
				+ reservePoint + ", point=" + point + "]";
	}
	
	
	
	
}
