package com.bookdabang.ljs.service;

import java.util.List;

import com.bookdabang.common.domain.CustomerService;

public interface CSBoardService {
	
	public List<CustomerService> showEntireCSBoard();
	
	public CustomerService readCSBoard(int postNo);

	public int writeCSPost(CustomerService csPost);
	
}
