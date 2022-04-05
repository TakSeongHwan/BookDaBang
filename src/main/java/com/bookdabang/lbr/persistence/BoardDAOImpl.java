package com.bookdabang.lbr.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.FreeBoard;
import com.bookdabang.common.domain.Recommend;
import com.bookdabang.common.domain.ReportBoard;


@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.boardMapper";
	
	// 자유게시판 전체보기
	@Override
	public List<FreeBoard> getListAllFreeBoards() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns + ".listAllFreeBoard");
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
	public int likeFreeBoard(Recommend recommend) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns +".likeFreeBoard", recommend);
	}

	@Override
	public int unlikeFreeBoard(Recommend recommend) throws Exception {
		// TODO Auto-generated method stub
		return ses.delete(ns + ".unilkeFreeBoard",recommend);
	}

	@Override
	public int countLikeCheck(Recommend recommend) throws Exception {
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





	
	



}
