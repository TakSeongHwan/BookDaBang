package com.bookdabang.common.domain;

public class OrderState {
	private int orderstate_code; 
	private String state;
	public OrderState() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderState(int orderstate_code, String state) {
		super();
		this.orderstate_code = orderstate_code;
		this.state = state;
	}
	public int getOrderstate_code() {
		return orderstate_code;
	}
	public void setOrderstate_code(int orderstate_code) {
		this.orderstate_code = orderstate_code;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	@Override
	public String toString() {
		return "OrderState [orderstate_code=" + orderstate_code + ", state=" + state + "]";
	}
	
}
