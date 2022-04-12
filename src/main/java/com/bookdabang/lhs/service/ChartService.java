package com.bookdabang.lhs.service;

import java.util.List;

import com.bookdabang.common.domain.ProductVO;

public interface ChartService {

	public List<ProductVO> getProductSort() throws Exception;

}
