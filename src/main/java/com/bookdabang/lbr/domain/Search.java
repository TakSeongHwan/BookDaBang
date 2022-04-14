package com.bookdabang.lbr.domain;

public class Search {
	private String searchtype;
	private String searchword;
	public Search() {
		super();
	}
	public Search(String searchtype, String searchword) {
		super();
		this.searchtype = searchtype;
		this.searchword = searchword;
	}
	public String getSearchtype() {
		return searchtype;
	}
	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}
	public String getSearchword() {
		return searchword;
	}
	public void setSearchword(String searchword) {
		this.searchword = searchword;
	}
	@Override
	public String toString() {
		return "Search [searchtype=" + searchtype + ", searchword=" + searchword + "]";
	}
	
	
}
