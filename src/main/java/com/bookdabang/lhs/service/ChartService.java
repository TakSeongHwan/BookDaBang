package com.bookdabang.lhs.service;

import java.util.List;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;

public interface ChartService {

	public List<ProductVO> getProductSort() throws Exception;

	public List<ProductVO> getRandomSelect() throws Exception;
	
	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception;

	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception;
}
