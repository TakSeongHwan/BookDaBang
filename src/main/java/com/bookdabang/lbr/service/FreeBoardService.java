package com.bookdabang.lbr.service;

import java.util.List;
import java.util.Map;



import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReportBoard;

import com.bookdabang.lbr.etc.BoardUploadFile;

public interface FreeBoardService {
	public Map<String, Object> listAllBoards(int pageNo, BoardSearch search) throws Exception;

	public Map<String, Object> readFreeBoard(int no, String ipAddr) throws Exception;

	public Map<String, Object> listAllReportBoards(int pageNo) throws Exception;

	public boolean insertReportBoard(ReportBoard reportboard) throws Exception;

	public boolean createFreeBoard(FreeBoard freeBoard, List<BoardUploadFile> upfilelst) throws Exception;

	public boolean removeFreeBoard(int no) throws Exception;

	public Map<String, Object> removeAllFreeBoard(int pageNo, BoardSearch search) throws Exception;

	public FreeBoard readDelBoard(int no) throws Exception;

	public boolean restorBoard(int no) throws Exception;

	public boolean likeFreeBoard(RecommendVO recommend) throws Exception;

	public boolean unlikeFreeBoard(RecommendVO recommend) throws Exception;

	public int countLikeCheck(RecommendVO recommend) throws Exception;
	
	public int countReportCheck(ReportBoard reportBoard) throws Exception;

	public int likeCount(int no)throws Exception;

	public int delLikeCount(int no)throws Exception;

	public boolean insertComment(FreeBoardComment comment) throws Exception;

	public List<FreeBoardComment> readComment(int boardno)throws Exception;

	public boolean modiComment(FreeBoardComment comment)throws Exception;

	public boolean delComment(int cno)throws Exception;

	// 수정할때
	public Map<String, Object> readFreeBoard(int no)throws Exception;

	public boolean reportfreeBoard(int board)throws Exception;

	public boolean reportStatus(int report)throws Exception;

	MemberVO getUser(String userId) throws Exception;

	public ReportBoard readreportBoard(int reportNo)throws Exception;

	public boolean updateFreeBoard(FreeBoard freeboard, List<BoardUploadFile> upfileLst) throws Exception;

	public boolean adminRemove(String boardno)throws Exception;

	public boolean admindelAttach(String boardno)throws Exception;

	public Map<String, Object> statusYesReportBoards(int pageNo) throws Exception;

	public Map<String, Object> statusNoReportBoards(int pageNo) throws Exception;



	

	



	
};
