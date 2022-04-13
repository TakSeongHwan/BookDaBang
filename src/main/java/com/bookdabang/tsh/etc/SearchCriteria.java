package com.bookdabang.tsh.etc;

public class SearchCriteria {
	private String searchWord;
	private String searchType;
	private String startSellDate;
	private String endSellDate;
	public SearchCriteria() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SearchCriteria(String searchWord, String searchType, String startSellDate, String endSellDate) {
		super();
		this.searchWord = searchWord;
		this.searchType = searchType;
		this.startSellDate = startSellDate;
		this.endSellDate = endSellDate;
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
	public String getStartSellDate() {
		return startSellDate;
	}
	public void setStartSellDate(String startSellDate) {
		this.startSellDate = startSellDate;
	}
	public String getEndSellDate() {
		return endSellDate;
	}
	public void setEndSellDate(String endSellDate) {
		this.endSellDate = endSellDate;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchWord=" + searchWord + ", searchType=" + searchType + ", startSellDate="
				+ startSellDate + ", endSellDate=" + endSellDate + "]";
	}
	
}
