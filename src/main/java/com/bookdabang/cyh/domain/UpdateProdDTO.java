package com.bookdabang.cyh.domain;

public class UpdateProdDTO {
	private String prodNo;
	private int updatePrice;
	private int updateStock;
	private String updateDisplay;
	private String updateSales;

	public UpdateProdDTO(String prodNo, int updatePrice, int updateStock, String updateDisplay, String updateSales) {
		super();
		this.prodNo = prodNo;
		this.updatePrice = updatePrice;
		this.updateStock = updateStock;
		this.updateDisplay = updateDisplay;
		this.updateSales = updateSales;
	}

	public UpdateProdDTO() {
		super();
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public int getUpdatePrice() {
		return updatePrice;
	}

	public void setUpdatePrice(int updatePrice) {
		this.updatePrice = updatePrice;
	}

	public int getUpdateStock() {
		return updateStock;
	}

	public void setUpdateStock(int updateStock) {
		this.updateStock = updateStock;
	}

	public String getUpdateDisplay() {
		return updateDisplay;
	}

	public void setUpdateDisplay(String updateDisplay) {
		this.updateDisplay = updateDisplay;
	}

	public String getUpdateSales() {
		return updateSales;
	}

	public void setUpdateSales(String updateSales) {
		this.updateSales = updateSales;
	}

	@Override
	public String toString() {
		return "UpdateProdDTO [prodNo=" + prodNo + ", updatePrice=" + updatePrice + ", updateStock=" + updateStock
				+ ", updateDisplay=" + updateDisplay + ", updateSales=" + updateSales + "]";
	}

}
