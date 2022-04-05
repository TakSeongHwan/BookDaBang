package com.bookdabang.lhs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.lhs.persistence.ChartDAO;


@Service
public class ChartServiceImpl implements ChartService {

	
	@Inject
	ChartDAO chartDAO;

}
