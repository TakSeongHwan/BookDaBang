package com.bookdabang.cyh.domain;

public class deleteProdDTO {
	private String prodNo;
	private String imagePath;

	public deleteProdDTO(String prodNo, String imagePath) {
		super();
		this.prodNo = prodNo;
		this.imagePath = imagePath;
	}

	public deleteProdDTO() {
		super();
	}

	public String getProdNo() {
		return prodNo;
	}

	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	@Override
	public String toString() {
		return "deleteProdDTO [prodNo=" + prodNo + ", imagePath=" + imagePath + "]";
	}

}
