package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class VisitorIPCheck {
	private String ipaddr; 
	private Timestamp accessdate;
	public VisitorIPCheck() {
		super();
		// TODO Auto-generated constructor stub
	}
	public VisitorIPCheck(String ipaddr, Timestamp accessdate) {
		super();
		this.ipaddr = ipaddr;
		this.accessdate = accessdate;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public Timestamp getAccessdate() {
		return accessdate;
	}
	public void setAccessdate(Timestamp accessdate) {
		this.accessdate = accessdate;
	}
	@Override
	public String toString() {
		return "VisitorIPCheck [ipaddr=" + ipaddr + ", accessdate=" + accessdate + "]";
	}
	
}
