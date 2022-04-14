package com.bookdabang.ljs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CustomerService;
import com.bookdabang.ljs.persistence.CSBoardDAO;


@Service
public class CSBoardServiceImpl implements CSBoardService {
	
	@Inject
	CSBoardDAO bdao;

	@Override
	public List<CustomerService> showEntireCSBoard() {
		
		return bdao.showEntireCSBoard();
	}

	@Override
	public CustomerService readCSBoard(int postNo) {
		 
		return bdao.readCSPost(postNo);
	}

	@Override
	public int writeCSPost(CustomerService csPost) {
		
		return bdao.writeCSPost(csPost);
	}

}
