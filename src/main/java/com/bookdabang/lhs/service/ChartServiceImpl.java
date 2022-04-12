package com.bookdabang.lhs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.lhs.persistence.ChartDAO;


@Service
public class ChartServiceImpl implements ChartService {

	
	@Inject
	ChartDAO chartDAO;

	@Override
	public List<ProductVO> getProductSort() throws Exception {
		// TODO Auto-generated method stub
		return chartDAO.getProductSort();
	}

}
