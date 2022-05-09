package com.bookdabang.ljs.domain;

public class CSUploadFile {
	
	private int csBoardNo;
	
	private String originFile; // 원본 파일의 이름
	private String thumbnailFile; // 이미지 파일일 경우 썸네일 이미지 파일의 이름
	private String notImageFile; // 이미지 파일이 아닌 경우의 파일 이름.\
	
	public int getCsBoardNo() {
		return csBoardNo;
	}
	public void setCsBoardNo(int csBoardNo) {
		this.csBoardNo = csBoardNo;
	}
	public String getOriginFile() {
		return originFile;
	}
	public void setOriginFile(String originFile) {
		this.originFile = originFile;
	}
	public String getThumbnailFile() {
		return thumbnailFile;
	}
	public void setThumbnailFile(String thumbnailFile) {
		this.thumbnailFile = thumbnailFile;
	}
	public String getNotImageFile() {
		return notImageFile;
	}
	public void setNotImageFile(String notImageFile) {
		this.notImageFile = notImageFile;
	}
	@Override
	public String toString() {
		return "CSUploadFile [csBoardNo=" + csBoardNo + ", originFile=" + originFile + ", thumbnailFile="
				+ thumbnailFile + ", notImageFile=" + notImageFile + "]";
	}
	
	
	
	
}
