package com.bookdabang.cyh.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;

public interface ProductService {
	public List<CategoryVO> getCategory() throws Exception;

	public Map<String, Object> conditionProdView(SearchCriteria sc, int pageno) throws Exception;
	
	public List<ProductVO>  selectProdView(List<String> checkProd) throws Exception;
}
