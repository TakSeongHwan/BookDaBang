package com.bookdabang.lbr.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.common.domain.PageView;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.common.etc.IPCheck;
import com.bookdabang.lbr.domain.Search;
import com.bookdabang.lbr.etc.BoardUploadFile;
import com.bookdabang.lbr.persistence.FreeBoardDAO;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {

	@Inject
	private FreeBoardDAO dao;

	@Override
	public Map<String, Object> listAllBoards(int pageNo, Search search) throws Exception {
		PagingInfo paging = pagingProcess(pageNo, search);

		List<FreeBoard> lst = null;
		if (search.getSearchtype() == null && search.getSearchtype() == null || search.getSearchtype().equals("")) {

			lst = dao.getListAllFreeBoards(paging);
		} else {
			lst = dao.getListAllFreeBoards(paging, search);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("freeBoard", lst);
		map.put("paging", paging);

		System.out.println(search.toString());	
		
		return map;
	}

	private PagingInfo pagingProcess(int pageNo, Search search) throws Exception {
		PagingInfo paging = new PagingInfo();

		if (search.getSearchtype() == null && search.getSearchword() == null || search.getSearchword().equals("")) {

			paging.setTotalPostCnt(dao.getTotalPost());
		} else {

			paging.setTotalPostCnt(dao.getSearchResultCnt(search));
		}

		paging.setTotalPage(paging.getTotalPostCnt());
		// 현재 페이지에서 출력 시작할 글번호
		paging.setStartNum(pageNo);

		// 전체 페이징 블럭 수
		paging.setTotalPagingBlock(paging.getTotalPage());

		// 현재 페이징 블럭
		paging.setCurrentPagingBlock(pageNo);

		// 현재 페이지에서의 시작 페이징블럭
		paging.setStartNoOfCurPagingBlock(paging.getCurrentPagingBlock());

		// 현재 페이지에서의 끝 페이징 블럭
		paging.setEndNoOfCurPagingBlock(paging.getStartNoOfCurPagingBlock());

		return paging;
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public Map<String, Object> readFreeBoard(int no, String ipAddr) throws Exception {

		
		PageView view = new PageView(ipAddr, no, 0, 0, null);
		view = dao.getReadCountProcess(view);
		if(view != null) {
			long beforeReadTime = view.getAccessDate().getTime();
			long currentTime = System.currentTimeMillis();
			long timeDiff = currentTime - beforeReadTime;
			long oneday = 1000 * 60 * 60 * 24;
			
			if(timeDiff >= oneday) {
				if(dao.updateReadCount(no) == 1) {
					dao.updateReadCountProcess(new PageView(ipAddr, no, 0, 0, new Timestamp(currentTime)));
				}
			}
		} else {
			if(dao.updateReadCount(no) == 1) {
				dao.insertReadCount(new PageView(ipAddr, no, 0, 0, null));
			}
		}
		
		
		
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
		if (rb == 1) {
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
			dao.insertAttachFile(new AttachFileVO(attachFile, 0, ref, 0, 0, 0, file.getOriginalFileName(),
					file.getThumbnailFileName(), file.getNotImageFileName()));

		}
		if (fb == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean removeFreeBoard(int no) throws Exception {
		boolean result = false;
		int rf = dao.removeFreeBoard(no);

		if (rf == 1) {
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

		if (rb == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean likeFreeBoard(RecommendVO recommend) throws Exception {
		boolean result = false;
		int lf = dao.likeFreeBoard(recommend);

		if (lf == 1) {
			result = true;
		}
		return result;

	}

	@Override
	public boolean unlikeFreeBoard(RecommendVO recommend) throws Exception {
		boolean result = false;
		int uf = dao.unlikeFreeBoard(recommend);

		if (uf == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public int countLikeCheck(RecommendVO recommend) throws Exception {

		return dao.countLikeCheck(recommend);
	}

	@Override
	public int countReportCheck(ReportBoard reportBoard) throws Exception {

		return dao.countReportCheck(reportBoard);
	}

	@Override
	public int likeCount(int no) throws Exception {
		return dao.likeCount(no);

	}

	@Override
	public int delLikeCount(int no) throws Exception {

		return dao.delLikeCount(no);
	}

	@Override
	public boolean insertComment(FreeBoardComment comment) throws Exception {
		boolean result = false;
		int ic = dao.insertComment(comment);

		if (ic == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public List<FreeBoardComment> readComment(int boardno) throws Exception {
		// TODO Auto-generated method stub
		return dao.readComment(boardno);
	}

	@Override
	public boolean modiComment(FreeBoardComment comment) throws Exception {
		boolean result = false;
		int mc = dao.modiComment(comment);
		if (mc == 1) {
			result = true;
		}
		return result;
	}

	@Override
	public boolean delComment(int cno) throws Exception {
		boolean result = false;

		int dc = dao.delComment(cno);
		if (dc == 1) {
			result = true;
		}
		return result;
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

//	@Override
//	public Map<String, Object> readReportBoard(int no) throws Exception {
//		FreeBoard freeBoard = dao.readFreeBoard(no);
//		ReportBoard reportBoard = dao.readReportBoard(no);
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		
//		resultMap.put("freeBoard", freeBoard);
//		resultMap.put("reportBoard", reportBoard);
//		
//		resultMap = dao.mreadReportBoard(resultMap);
//		
//
//		return resultMap;
//		
//	}

}
