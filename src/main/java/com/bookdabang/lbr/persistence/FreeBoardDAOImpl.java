package com.bookdabang.lbr.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.FreeBoardComment;
import com.bookdabang.common.domain.PageView;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.RecommendVO;
import com.bookdabang.common.domain.ReportBoard;
import com.bookdabang.lbr.domain.Search;


@Repository
public class FreeBoardDAOImpl implements FreeBoardDAO {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.boardMapper";
	
	// 자유게시판 전체보기
	@Override
	public List<FreeBoard> getListAllFreeBoards(PagingInfo paging) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".listAllFreeBoard",paging);
	}
	

	@Override
	public List<FreeBoard> getListAllFreeBoards(PagingInfo paging, Search search) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("Searchtype", search.getSearchtype());
		param.put("Searchword", search.getSearchword());
		param.put("StartNum", paging.getStartNum());
		param.put("PostPerPage", paging.getPostPerPage());
		
		return ses.selectList(ns + ".getSearchResultList", param);
	}


	@Override
	public int getSearchResultCnt(Search search) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getSearchResultCnt", search);
	}

	// 신고게시판 전체보기
	@Override
	public List<ReportBoard> getListAllReportBoards() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".listAllReportBoard");
	}

	// 게시글 신고하기
	@Override
	public int insertReportBoard(ReportBoard reportboard) {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertReportBoard", reportboard);
	}

	// 자유게시판 글쓰기
	@Override
	public int insertFreeBoard(FreeBoard freeBoard) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertFreeBoard", freeBoard);
	}

	@Override
	public int insertAttachFile(AttachFileVO file) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertAttachFile", file);
	}

	@Override
	public int getNextNo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getMaxno");
	}

	

	@Override
	public int removeFreeBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".removeFreeBoard", no);
	}

	@Override
	public List<FreeBoard> removeAllFreeBoard() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".removeAllFreeBoard");
	}

	@Override
	public FreeBoard getReadDelBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".readDelBoard", no);
	}

	@Override
	public int restorBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".restoreBoard", no);
	}

	
	
	@Override
	public int readFileNo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns+".readMaxFileNo");
	}

	@Override
	public int likeFreeBoard(RecommendVO recommend) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns +".likeFreeBoard", recommend);
	}

	@Override
	public int unlikeFreeBoard(RecommendVO recommend) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns + ".unilkeFreeBoard",recommend);
	}

	@Override
	public int countLikeCheck(RecommendVO recommend) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".countLikeCheck", recommend);
	}

	@Override
	public int countReportCheck(ReportBoard reportBoard) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".countReportBoard", reportBoard);
	}

	@Override
	public FreeBoard readFreeBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".readFreeBoard", no);
	}

	@Override
	public List<AttachFileVO> readFile(int no) {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".readFile", no);
	}



	@Override
	public int likeCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".countLike", no);
	}



	@Override
	public int delLikeCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".delLikeCount", no);
	}



	@Override
	public int insertComment(FreeBoardComment comment) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertComment", comment);
	}



	@Override
	public List<FreeBoardComment> readComment(int boardno) throws Exception {
		
		return ses.selectList(ns + ".readComment", boardno);
	}



	@Override
	public int modiComment(FreeBoardComment comment) {
		// TODO Auto-generated method stub
		return ses.update(ns + ".modiComment", comment);
	}



	@Override
	public int delComment(int cno) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns + ".delComment", cno);
	}



	@Override
	public ReportBoard readReportBoard(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".readReportBoard", no);
	}





	@Override
	public int getTotalPost() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".totalPost");
	}


	@Override
	public PageView getReadCountProcess(PageView view) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + ".getReadCount", view);
	}


	@Override
	public int updateReadCount(int no) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".updateReadCount", no);
	}


	@Override
	public int updateReadCountProcess(PageView view) throws Exception {
		// TODO Auto-generated method stub
		return ses.update(ns + ".updateReadCountProcess", view);
	}


	@Override
	public int insertReadCount(PageView view) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns + ".insertReadCount", view);
	}



	



	




	
	



}
