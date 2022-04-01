package com.bookdabang.common.domain;

public class PagingInfo {

	private int postPerPage = 3; // 1페이지당 보여 줄 글의 개수
	private int pageCntPerBlock = 2; // 1개의 블럭에 보여줄 페이지 수
	private int totalPage; // 전체 페이지 수
	private int totalPostCnt; // 전체 글의 개수

	private int startNum; // 출력을 시작할 글 번호

	private int totalPagingBlock; // 전체 페이징 블럭 수
	private int currentPagingBlock; // 현재 페이지가 속한 페이징 블럭 번호
	private int startNoOfCurPagingBlock; // 블록의 시작 페이지 번호
	private int endNoOfCurPagingBlock; // 블록의 끝 페이지 번호

	public PagingInfo() {

	}

	public PagingInfo(int postPerPage, int pageCntPerBlock, int totalPage, int totalPostCnt, int startNum,
			int totalPagingBlock, int currentPagingBlock, int startNoOfCurPagingBlock, int endNoOfCurPagingBlock) {
		super();
		this.postPerPage = postPerPage;
		this.pageCntPerBlock = pageCntPerBlock;
		this.totalPage = totalPage;
		this.totalPostCnt = totalPostCnt;
		this.startNum = startNum;
		this.totalPagingBlock = totalPagingBlock;
		this.currentPagingBlock = currentPagingBlock;
		this.startNoOfCurPagingBlock = startNoOfCurPagingBlock;
		this.endNoOfCurPagingBlock = endNoOfCurPagingBlock;
	}

	public int getPostPerPage() {
		return postPerPage;
	}

	public void setPostPerPage(int postPerPage) {
		this.postPerPage = postPerPage;
	}

	public int getPageCntPerBlock() {
		return pageCntPerBlock;
	}

	public void setPageCntPerBlock(int pageCntPerBlock) {
		this.pageCntPerBlock = pageCntPerBlock;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		// 전체 페이지 수 : 전체 글의 갯수 / 페이지당 보여줄 글의 갯수(나누어 떨어지지 않았다면 +1)
		// this.totalPage = (int)Math.ceil((double)totalPage/getPostPerPage());
		if (totalPage % this.postPerPage != 0) {
			this.totalPage = (totalPage / this.postPerPage) + 1;
		} else {
			this.totalPage = (totalPage / this.postPerPage);
		}
	}

	public int getTotalPostCnt() {
		return totalPostCnt;
	}

	public void setTotalPostCnt(int totalPostCnt) {
		this.totalPostCnt = totalPostCnt;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int pageNo) {
		// x번째 페이지에서 출력을 시작할 글 번호 : ((x-1) * 한페이지당 보여줄 글의 갯수)
		this.startNum = (pageNo - 1) * this.postPerPage;
	}

	public int getTotalPagingBlock() {
		return totalPagingBlock;
	}

	public void setTotalPagingBlock(int totalPage) {
		// 전체 페이징 블럭 수 : 전체 페이지수 / 4 (나누어 떨어지지 않으면 몫 + 1)
		this.totalPagingBlock = (int) Math.ceil((double) (totalPage) / this.pageCntPerBlock);
	}

	public int getCurrentPagingBlock() {
		return currentPagingBlock;
	}

	public void setCurrentPagingBlock(int pageNo) {
		// 현재 페이징 블럭 : 현재 페이지 번호 / 페이징 (나머지있으면 올림)
		this.currentPagingBlock = (int) Math.ceil((double) pageNo / this.pageCntPerBlock);
	}

	public int getStartNoOfCurPagingBlock() {
		return startNoOfCurPagingBlock;
	}

	public void setStartNoOfCurPagingBlock(int currentPagingBlock) {
		// ((현재 페이지 블럭 -1) * 페이징 블럭) +1
		this.startNoOfCurPagingBlock = ((currentPagingBlock - 1) * this.pageCntPerBlock) + 1;
	}

	public int getEndNoOfCurPagingBlock() {
		return endNoOfCurPagingBlock;
	}

	public void setEndNoOfCurPagingBlock(int startNoOfCurPagingBlock) {
		// 시작번호 + 페이징블럭 -1
		this.endNoOfCurPagingBlock = (startNoOfCurPagingBlock) + this.pageCntPerBlock - 1;
		if (this.totalPage < this.endNoOfCurPagingBlock) {
			this.endNoOfCurPagingBlock = this.totalPage;
		}
	}

	@Override
	public String toString() {
		return "PagingInfo [postPerPage=" + postPerPage + ", pageCntPerBlock=" + pageCntPerBlock + ", totalPage="
				+ totalPage + ", totalPostCnt=" + totalPostCnt + ", startNum=" + startNum + ", totalPagingBlock="
				+ totalPagingBlock + ", currentPagingBlock=" + currentPagingBlock + ", startNoOfCurPagingBlock="
				+ startNoOfCurPagingBlock + ", endNoOfCurPagingBlock=" + endNoOfCurPagingBlock + "]";
	}

}
