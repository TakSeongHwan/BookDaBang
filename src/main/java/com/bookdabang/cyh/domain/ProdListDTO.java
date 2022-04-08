package com.bookdabang.cyh.domain;

import java.util.List;

public class ProdListDTO {
	private List<UpdateProdDTO> products;

	public ProdListDTO(List<UpdateProdDTO> products) {
		super();
		this.products = products;
	}

	public ProdListDTO() {
		super();
	}

	public List<UpdateProdDTO> getProducts() {
		return products;
	}

	public void setProducts(List<UpdateProdDTO> products) {
		this.products = products;
	}

	@Override
	public String toString() {
		return "ProdListDTO [products=" + products + "]";
	}

}
