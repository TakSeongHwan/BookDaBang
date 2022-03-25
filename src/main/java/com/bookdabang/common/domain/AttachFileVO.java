package com.bookdabang.common.domain;

public class AttachFileVO {
	private int attachFileNo;
	private int noticeNo;
	private int freeboardNo; 
	private int reviewNo; 
	private int productNo; 
	private int originFile; 
	private String thumbnailFile; 
	private String notImageFile;
	
	public AttachFileVO() {}

	public AttachFileVO(int attachFileNo, int noticeNo, int freeboardNo, int reviewNo, int productNo, int originFile,
			String thumbnailFile, String notImageFile) {
		super();
		this.attachFileNo = attachFileNo;
		this.noticeNo = noticeNo;
		this.freeboardNo = freeboardNo;
		this.reviewNo = reviewNo;
		this.productNo = productNo;
		this.originFile = originFile;
		this.thumbnailFile = thumbnailFile;
		this.notImageFile = notImageFile;
	}

	public int getAttachFileNo() {
		return attachFileNo;
	}

	public void setAttachFileNo(int attachFileNo) {
		this.attachFileNo = attachFileNo;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public int getFreeboardNo() {
		return freeboardNo;
	}

	public void setFreeboardNo(int freeboardNo) {
		this.freeboardNo = freeboardNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getOriginFile() {
		return originFile;
	}

	public void setOriginFile(int originFile) {
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
		return "AttachFile [attachFileNo=" + attachFileNo + ", noticeNo=" + noticeNo + ", freeboardNo=" + freeboardNo
				+ ", reviewNo=" + reviewNo + ", productNo=" + productNo + ", originFile=" + originFile
				+ ", thumbnailFile=" + thumbnailFile + ", notImageFile=" + notImageFile + "]";
	}
	
}
