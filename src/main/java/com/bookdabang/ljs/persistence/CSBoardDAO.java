package com.bookdabang.ljs.persistence;

import java.util.List;

import com.bookdabang.common.domain.AttachFileVO;
import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.ljs.domain.CSUploadFile;

public interface CSBoardDAO {

	public List<CustomerService> showEntireCSBoard( ) throws Exception;

	public CustomerService readCSPost(int postNo) throws Exception;
	
	public int writeCSPost(CustomerService csPost) throws Exception;

	public List<AttachFileVO> getAttachFiles(int postNo) throws Exception;

	public int insertAttachFile(CSUploadFile csFileAttached) throws Exception;
	
	public int getNextNo() throws Exception;

	public int deleteCSPost(int postNo) throws Exception;
	
	public int deleteAttach (int postNo) throws Exception;
	
}
