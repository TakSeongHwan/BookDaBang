package com.bookdabang.cyh.persistence;

import java.util.List;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;

public interface ProductDAO {
	
	public List<CategoryVO> getCategory() throws Exception;
	public int conditionProdCnt(SearchCriteria sc) throws Exception;
	public List<ProductVO> conditionProdView(SearchCriteria sc, PagingInfo pi) throws Exception;
	

}
