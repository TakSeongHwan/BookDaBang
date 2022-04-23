package com.bookdabang.khn.etc;

public class UploadFile {
	private String originalFileName; // 원본 파일의 이름
	private String thumbnailFileName; // 이미지 파일일 경우 썸네일 이미지 파일의 이름
	private String notImgaeFileName; // 이미지 파일이 아닌경우의 파일이름
	
	public UploadFile(String originalFileName, String thumbnailFileName, String notImgaeFileName) {
		super();
		this.originalFileName = originalFileName;
		this.thumbnailFileName = thumbnailFileName;
		this.notImgaeFileName = notImgaeFileName;
	}

	public UploadFile() {
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

	public String getNotImgaeFileName() {
		return notImgaeFileName;
	}

	public void setNotImgaeFileName(String notImgaeFileName) {
		this.notImgaeFileName = notImgaeFileName;
	}

	@Override
	public String toString() {
		return "UploadFile [originalFileName=" + originalFileName + ", thumbnailFileName=" + thumbnailFileName
				+ ", notImgaeFileName=" + notImgaeFileName + "]";
	}
}
