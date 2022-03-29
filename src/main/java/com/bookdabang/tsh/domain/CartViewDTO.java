package com.bookdabang.tsh.domain;

public class CartViewDTO {
	private int product_no;
	private int cartNo;
	private String title;
	private String cover;
	private int sell_price;
	private int productQtt;
	public CartViewDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CartViewDTO(int product_no, int cartNo, String title, String cover, int sell_price, int productQtt) {
		super();
		this.product_no = product_no;
		this.cartNo = cartNo;
		this.title = title;
		this.cover = cover;
		this.sell_price = sell_price;
		this.productQtt = productQtt;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
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
	public int getSell_price() {
		return sell_price;
	}
	public void setSell_price(int sell_price) {
		this.sell_price = sell_price;
	}
	public int getProductQtt() {
		return productQtt;
	}
	public void setProductQtt(int productQtt) {
		this.productQtt = productQtt;
	}
	@Override
	public String toString() {
		return "CartViewDTO [product_no=" + product_no + ", cartNo=" + cartNo + ", title=" + title + ", cover=" + cover
				+ ", sell_price=" + sell_price + ", productQtt=" + productQtt + "]";
	}
	
	
}
