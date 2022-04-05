package com.bookdabang.cyh.domain;

public class SearchCriteria {
	private String searchWord;
	private String searchType;
	private String category_code;
	private String startRgDate;
	private String endRgDate;
	private String startUpdate;
	private String endUpDate;
	private String display_status;
	private String sales_status;
	private String sortWord;
	private String sortMethod;

	public SearchCriteria(String searchWord, String searchType, String category_code, String startRgDate,
			String endRgDate, String startUpdate, String endUpDate, String display_status, String sales_status,
			String sortWord, String sortMethod) {
		super();
		this.searchWord = searchWord;
		this.searchType = searchType;
		this.category_code = category_code;
		this.startRgDate = startRgDate;
		this.endRgDate = endRgDate;
		this.startUpdate = startUpdate;
		this.endUpDate = endUpDate;
		this.display_status = display_status;
		this.sales_status = sales_status;
		this.sortWord = sortWord;
		this.sortMethod = sortMethod;
	}

	public SearchCriteria() {
		super();
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getCategory_code() {
		return category_code;
	}

	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}

	public String getStartRgDate() {
		return startRgDate;
	}

	public void setStartRgDate(String startRgDate) {
		this.startRgDate = startRgDate;
	}

	public String getEndRgDate() {
		return endRgDate;
	}

	public void setEndRgDate(String endRgDate) {
		this.endRgDate = endRgDate;
	}

	public String getStartUpdate() {
		return startUpdate;
	}

	public void setStartUpdate(String startUpdate) {
		this.startUpdate = startUpdate;
	}

	public String getEndUpDate() {
		return endUpDate;
	}

	public void setEndUpDate(String endUpDate) {
		this.endUpDate = endUpDate;
	}

	public String getDisplay_status() {
		return display_status;
	}

	public void setDisplay_status(String display_status) {
		this.display_status = display_status;
	}

	public String getSales_status() {
		return sales_status;
	}

	public void setSales_status(String sales_status) {
		this.sales_status = sales_status;
	}

	public String getSortWord() {
		return sortWord;
	}

	public void setSortWord(String sortWord) {
		this.sortWord = sortWord;
	}

	public String getSortMethod() {
		return sortMethod;
	}

	public void setSortMethod(String sortMethod) {
		this.sortMethod = sortMethod;
	}

	@Override
	public String toString() {
		return "SearchCriteria [searchWord=" + searchWord + ", searchType=" + searchType + ", category_code="
				+ category_code + ", startRgDate=" + startRgDate + ", endRgDate=" + endRgDate + ", startUpdate="
				+ startUpdate + ", endUpDate=" + endUpDate + ", display_status=" + display_status + ", sales_status="
				+ sales_status + ", sortWord=" + sortWord + ", sortMethod=" + sortMethod + "]";
	}

}
