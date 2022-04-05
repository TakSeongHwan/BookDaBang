package com.bookdabang.lbr.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;

import com.bookdabang.lbr.etc.BoardUploadFile;
import com.bookdabang.lbr.persistence.FreeBoardDAO;


@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	@Inject
	private FreeBoardDAO dao;
	
	
	@Override
	public List<FreeBoard> listAllBoards() throws Exception {
		
		return dao.getListAllFreeBoards();
	}


	@Override
	public Map<String, Object> readFreeBoard(int no) throws Exception {
		FreeBoard freeBoard = dao.readFreeBoard(no);
		
		List<AttachFileVO> fileLst = dao.readFile(no);
		
		if (fileLst.size() == 0) {
			fileLst = null;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("freeBoard", freeBoard);
		resultMap.put("fileLst", fileLst);
		
		return resultMap;
	}


	@Override
	public List<ReportBoard> listAllReportBoards() throws Exception {
		return dao.getListAllReportBoards();
	}


	@Override
	public boolean insertReportBoard(ReportBoard reportboard) throws Exception {
		boolean result = false;
		int rb = dao.insertReportBoard(reportboard);
		if(rb == 1) {
			result = true;
		}
		return result;
	}


	@Override
	public boolean createFreeBoard(FreeBoard freeBoard, List<BoardUploadFile> uploadLst) throws Exception {
		boolean result = false;
		int fb = dao.insertFreeBoard(freeBoard);
		int ref = dao.getNextNo(); // 게시판번호
		
		freeBoard.setContent(freeBoard.getContent().replace("\r\n", "<br />"));
		
		int attachFile = dao.readFileNo() + 1; // 파일번호
		
		for (BoardUploadFile file : uploadLst) {
			dao.insertAttachFile(new AttachFileVO(attachFile, 0, ref, 0, 0,file.getOriginalFileName(), file.getThumbnailFileName(), file.getNotImageFileName()));
			
			
		}
		if(fb == 1) {
			result =true;
		}
		return result;
	}


	
	

	@Override
	public boolean removeFreeBoard(int no) throws Exception {
		boolean result = false;
		int rf = dao.removeFreeBoard(no);
		
		if(rf ==1) {
			result = true;
		}
		return result;
	}


	@Override
	public List<FreeBoard> removeAllFreeBoard() throws Exception {
		// TODO Auto-generated method stub
		return dao.removeAllFreeBoard();
	}


	@Override
	public FreeBoard readDelBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return dao.getReadDelBoard(no);
	}


	@Override
	public boolean restorBoard(int no) throws Exception {
		boolean result = false;
		int rb = dao.restorBoard(no);
		
		if(rb ==1) {
			result = true;
		}
		return result;
		}
	
	@Override
	public boolean likeFreeBoard(Recommend recommend) throws Exception {
		boolean result = false;
		int lf = dao.likeFreeBoard(recommend);
		
		if(lf ==1) {
			result = true;
		}
		return result;
	
	}


	@Override
	public boolean unlikeFreeBoard(Recommend recommend) throws Exception {
		boolean result = false;
		int uf = dao.unlikeFreeBoard(recommend);
		
		if(uf ==1) {
			result = true;
		}
		return result;
	}


	@Override
	public int countLikeCheck(Recommend recommend) throws Exception {
		
		return dao.countLikeCheck(recommend);
	}


	@Override
	public int countReportCheck(ReportBoard reportBoard) throws Exception {
		// TODO Auto-generated method stub
		return dao.countReportCheck(reportBoard);
	}


	}




	


	


	


