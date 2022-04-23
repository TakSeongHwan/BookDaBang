package com.bookdabang.ljs.domain;

public class CSUploadFile {
	private String originalFileName; // 원본 파일의 이름
	private String thumbnailFileName; // 이미지 파일일 경우 썸네일 이미지 파일의 이름
	private String notImageFileName; // 이미지 파일이 아닌 경우의 파일 이름.
	
	public CSUploadFile(String originalFileName, String thumbnailFileName, String notImageFileName) {
		super();
		this.originalFileName = originalFileName;
		this.thumbnailFileName = thumbnailFileName;
		this.notImageFileName = notImageFileName;
	}
	public CSUploadFile() {
		// TODO Auto-generated constructor stub
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getThumbnailFileName() {
		return thumbnailFileName;
	}
	public void setThumbnailFileName(String thumbnailFileName) {
		this.thumbnailFileName = thumbnailFileName;
	}
	public String getNotImageFileName() {
		return notImageFileName;
	}
	public void setNotImageFileName(String notImageFileName) {
		this.notImageFileName = notImageFileName;
	}
	@Override
	public String toString() {
		return "UploadFile [originalFileName=" + originalFileName + ", thumbnailFileName=" + thumbnailFileName
				+ ", notImageFileName=" + notImageFileName + "]";
	}
	
	
}
