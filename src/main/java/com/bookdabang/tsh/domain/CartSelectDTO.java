package com.bookdabang.tsh.domain;

public class CartSelectDTO {
	private String userId;
	private String ipaddr;
	public CartSelectDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CartSelectDTO(String userId, String ipaddr) {
		super();
		this.userId = userId;
		this.ipaddr = ipaddr;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	@Override
	public String toString() {
		return "CartSelectDTO [userId=" + userId + ", ipaddr=" + ipaddr + "]";
	}
	
	
}
