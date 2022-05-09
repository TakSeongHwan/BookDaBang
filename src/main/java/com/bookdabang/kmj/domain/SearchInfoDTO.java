package com.bookdabang.kmj.domain;

import java.sql.Timestamp;

public class SearchInfoDTO {
	private String searchType;
	private String searchWord;
	private String startDate;
	private String endDate;
	private String startStar;
	private String endStar;
	private String fileStatus;
	private int pageNo;
	private int order;
	
	public SearchInfoDTO() {
		super();
	}

	public SearchInfoDTO(String searchType, String searchWord, String startDate,
			String endDate, String startStar, String endStar,  String fileStatus,
			int pageNo, int order) {
		super();
		this.searchType = searchType;
		this.searchWord = searchWord;
		this.startDate = startDate;
		this.endDate = endDate;
		this.startStar = startStar;
		this.endStar = endStar;
		this.fileStatus = fileStatus;
		this.pageNo = pageNo;
		this.order = order;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStartStar() {
		return startStar;
	}

	public void setStartStar(String startStar) {
		this.startStar = startStar;
	}

	public String getEndStar() {
		return endStar;
	}

	public void setEndStar(String endStar) {
		this.endStar = endStar;
	}

	public String getFileStatus() {
		return fileStatus;
	}

	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	@Override
	public String toString() {
		return "SearchInfoDTO [searchType=" + searchType + ", searchWord=" + searchWord + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", startStar=" + startStar + ", endStar=" + endStar + ", fileStatus="
				+ fileStatus + ", pageNo=" + pageNo + ", order=" + order + "]";
	}
	
}
