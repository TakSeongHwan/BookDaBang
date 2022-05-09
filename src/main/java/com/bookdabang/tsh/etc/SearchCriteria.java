package com.bookdabang.tsh.etc;

public class SearchCriteria {
	private String searchWord;
	private String searchType;
	private String startSellDate;
	private String endSellDate;
	private int orderState;
	private String confirm;
	private boolean all;
	public SearchCriteria() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SearchCriteria(String searchWord, String searchType, String startSellDate, String endSellDate,
			int orderState, String confirm, boolean all) {
		super();
		this.searchWord = searchWord;
		this.searchType = searchType;
		this.startSellDate = startSellDate;
		this.endSellDate = endSellDate;
		this.orderState = orderState;
		this.confirm = confirm;
		this.all = all;
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
	public int getOrderState() {
		return orderState;
	}
	public void setOrderState(int orderState) {
		this.orderState = orderState;
	}
	public String getConfirm() {
		return confirm;
	}
	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}
	public boolean isAll() {
		return all;
	}
	public void setAll(boolean all) {
		this.all = all;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchWord=" + searchWord + ", searchType=" + searchType + ", startSellDate="
				+ startSellDate + ", endSellDate=" + endSellDate + ", orderState=" + orderState + ", confirm=" + confirm
				+ ", all=" + all + "]";
	}
	
}
