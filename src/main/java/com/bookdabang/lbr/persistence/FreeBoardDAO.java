package com.bookdabang.lbr.persistence;

import java.util.List;


import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.common.domain.PageView;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.lbr.domain.Search;




public interface FreeBoardDAO {

	
	// 자유게시판 전체 목록 
	public List<FreeBoard> getListAllFreeBoards(PagingInfo paging) throws Exception;
	
	public List<FreeBoard> getListAllFreeBoards(PagingInfo paging, Search search);
	
	public int getTotalPost() throws Exception;
	
	public int getSearchResultCnt(Search search) throws Exception;
	
	// 자유게시판 상세보기
	public FreeBoard readFreeBoard(int no)throws Exception;
	// 파일보기
	public List<AttachFileVO> readFile(int no);
	// 신고게시판 전체보기
	public List<ReportBoard> getListAllReportBoards()throws Exception;
	// 게시글 신고하기
	public int insertReportBoard(ReportBoard reportboard)throws Exception;
	
	public int insertFreeBoard(FreeBoard freeBoard)throws Exception;
	// 파일 첨부하기
	public int insertAttachFile(AttachFileVO file)throws Exception;

	public int getNextNo() throws Exception;
	// 자유게시판 지우기
	public int removeFreeBoard(int no)throws Exception;
	// 삭제된 게시물 전체보기
	public List<FreeBoard> removeAllFreeBoard()throws Exception;

	public FreeBoard getReadDelBoard(int no)throws Exception;

	public int restorBoard(int no)throws Exception;
	
	public int readFileNo() throws Exception;

	public int likeFreeBoard(Recommend recommend)throws Exception;

	public int unlikeFreeBoard(Recommend recommend)throws Exception;

	public int countLikeCheck(Recommend recommend)throws Exception;

	public int countReportCheck(ReportBoard reportBoard)throws Exception;

	public int likeCount(int no)throws Exception;

	public int delLikeCount(int no)throws Exception;
	
	public int insertComment(FreeBoardComment comment)throws Exception;
	
	public List<FreeBoardComment> readComment(int boardno)throws Exception;
	
	public int modiComment(FreeBoardComment comment)throws Exception;
	
	public int delComment(int cno)throws Exception;
	
	
	public ReportBoard readReportBoard(int no)throws Exception;

	public PageView getReadCountProcess(PageView view)throws Exception;

	public int updateReadCount(int no)throws Exception;

	public int updateReadCountProcess(PageView view)throws Exception;
	
	public int insertReadCount(PageView view)throws Exception;
	
	
	//public Map<String, Object> mreadReportBoard(Map<String, Object> resultMap)throws Exception;



	


	
}
