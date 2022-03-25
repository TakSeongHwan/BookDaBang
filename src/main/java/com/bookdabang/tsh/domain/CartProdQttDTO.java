package com.bookdabang.tsh.domain;

public class CartProdQttDTO {
	private int cartNo;  
	private int productQtt;
	public CartProdQttDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CartProdQttDTO(int cartNo, int productQtt) {
		super();
		this.cartNo = cartNo;
		this.productQtt = productQtt;
	}
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getProductQtt() {
		return productQtt;
	}
	public void setProductQtt(int productQtt) {
		this.productQtt = productQtt;
	}
	@Override
	public String toString() {
		return "CartProdQttDTO [cartNo=" + cartNo + ", productQtt=" + productQtt + "]";
	}
	
}
