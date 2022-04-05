package com.bookdabang.lbr.persistence;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;




public interface FreeBoardDAO {


	public List<FreeBoard> getListAllFreeBoards() throws Exception;

	//public Map<String, Object> getreadFreeBoard(int no)throws Exception;
	
	public FreeBoard readFreeBoard(int no)throws Exception;
	
	public List<AttachFileVO> readFile(int no);
	
	public List<ReportBoard> getListAllReportBoards()throws Exception;

	public int insertReportBoard(ReportBoard reportboard)throws Exception;
	
	public int insertFreeBoard(FreeBoard freeBoard)throws Exception;
	
	public int insertAttachFile(AttachFileVO file)throws Exception;

	public int getNextNo() throws Exception;

	public int removeFreeBoard(int no)throws Exception;

	public List<FreeBoard> removeAllFreeBoard()throws Exception;

	public FreeBoard getReadDelBoard(int no)throws Exception;

	public int restorBoard(int no)throws Exception;
	
	public int readFileNo() throws Exception;

	public int likeFreeBoard(Recommend recommend)throws Exception;

	public int unlikeFreeBoard(Recommend recommend)throws Exception;

	public int countLikeCheck(Recommend recommend)throws Exception;

	public int countReportCheck(ReportBoard reportBoard)throws Exception;



	


	
}
