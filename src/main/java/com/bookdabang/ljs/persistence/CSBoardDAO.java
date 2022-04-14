package com.bookdabang.ljs.persistence;

import java.util.List;

import com.bookdabang.common.domain.CustomerService;

public interface CSBoardDAO {

	public List<CustomerService> showEntireCSBoard( );

	public CustomerService readCSPost(int postNo);
	
	public int writeCSPost(CustomerService csPost);
	
}
