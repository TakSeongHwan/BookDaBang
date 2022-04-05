package com.bookdabang.lbr.etc;

public class BoardUploadFile {
	private String originalFileName;
	private String thumbnailFileName;
	private String notImageFileName;
	
	
	public BoardUploadFile() {
		
	}
	public BoardUploadFile(String originalFileName, String thumbnailFileName, String notImageFileName) {
		super();
		this.originalFileName = originalFileName;
		this.thumbnailFileName = thumbnailFileName;
		this.notImageFileName = notImageFileName;
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
