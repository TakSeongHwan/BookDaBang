package com.bookdabang.ljs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.BoardSearch;
import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.ljs.domain.CSUploadFile;

@Repository
public class CSBoardDAOImpl implements CSBoardDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.csBoardMapper";

	@Override
	public List<CustomerService> showEntireCSBoard(PagingInfo pi) throws Exception {
		
		return ses.selectList(ns + ".showEntireCSBoard", pi);
	}
	
	@Override
	public List<CustomerService> showEntireCSBoard(PagingInfo pi, BoardSearch searchWord) {
		 
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchType", searchWord.getSearchType());
		map.put("searchWord", searchWord.getSearchWord());
		map.put("startNum", pi.getStartNum());
		map.put("postPerPage", pi.getPostPerPage());
		
		System.out.println(map.toString());
		System.out.println(searchWord.toString());
		
		return ses.selectList(ns + ".getSearchResultList", map);
	}

	@Override
	public CustomerService readCSPost(int postNo) throws Exception {
		 
		return ses.selectOne(ns + ".readCSPost", postNo);
	}

	@Override
	public int writeCSPost(CustomerService csPost) throws Exception {
		
		return ses.insert(ns + ".writeCSPost", csPost);
	}

	@Override
	public List<AttachFileVO> getAttachFiles(int postNo) throws Exception {
		
		return ses.selectList(ns + ".attachFilesInCS", postNo);
	}

	@Override
	public int insertAttachFile(CSUploadFile csFileAttached) throws Exception {
		
		return ses.insert(ns + ".insertCSAttachFile", csFileAttached);
	}

	@Override
	public int getNextNo() throws Exception {
		
		return ses.selectOne(ns + ".getNextNo");
	}

	@Override
	public int deleteCSPost(int postNo) throws Exception {
		
		return ses.delete(ns + ".deleteCSPost", postNo); 
	}

	@Override
	public int deleteAttach(int postNo) throws Exception {

		return ses.delete(ns + ".deleteAttachFile", postNo);
	}

	@Override
	public int getTotalPost() throws Exception {
		 
		return ses.selectOne(ns + ".getTotalPost");
	}

	@Override
	public int getSearchResultCnt(BoardSearch searchWord) {
		
		return ses.selectOne(ns + ".getSearchResultCnt", searchWord);
	}



}
