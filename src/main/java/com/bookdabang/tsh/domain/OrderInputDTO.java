package com.bookdabang.tsh.domain;


public class OrderInputDTO {
	private String cartsNo;
	private String orderPwd;
	private int addressNo;
	public OrderInputDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public OrderInputDTO(String cartsNo, String orderPwd, int addressNo) {
		super();
		this.cartsNo = cartsNo;
		this.orderPwd = orderPwd;
		this.addressNo = addressNo;
	}
	public String getCartsNo() {
		return cartsNo;
	}
	public void setCartsNo(String cartsNo) {
		this.cartsNo = cartsNo;
	}
	public String getOrderPwd() {
		return orderPwd;
	}
	public void setOrderPwd(String orderPwd) {
		this.orderPwd = orderPwd;
	}
	public int getAddressNo() {
		return addressNo;
	}
	public void setAddressNo(int addressNo) {
		this.addressNo = addressNo;
	}
	@Override
	public String toString() {
		return "OrderInputDTO [cartsNo=" + cartsNo + ", orderPwd=" + orderPwd + ", addressNo=" + addressNo + "]";
	}
	
	

}
