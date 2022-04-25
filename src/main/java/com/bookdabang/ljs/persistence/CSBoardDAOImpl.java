package com.bookdabang.ljs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.ljs.domain.CSUploadFile;

@Repository
public class CSBoardDAOImpl implements CSBoardDAO {
	
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.bookdabang.mapper.csBoardMapper";

	@Override
	public List<CustomerService> showEntireCSBoard() throws Exception {
		
		return ses.selectList(ns + ".showEntireCSBoard");
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

		return ses.delete(ns + "deleteAttachFile", postNo);
	}

}
