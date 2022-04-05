package com.bookdabang.lbr.persistence;

import java.util.List;


import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;




public interface FreeBoardDAO {

	// 자유게시판 전체 목록 
	public List<FreeBoard> getListAllFreeBoards() throws Exception;
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



	


	
}
