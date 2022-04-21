package com.bookdabang.ljs.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.ljs.domain.CSUploadFile;

public interface CSBoardService {
	
	public List<CustomerService> showEntireCSBoard() throws Exception;
	
	public Map<String, Object> readCSBoard(int postNo) throws Exception, IOException;

	public boolean writeCSPost(CustomerService csPost, List<CSUploadFile> upfileLst) throws Exception;
	
}
