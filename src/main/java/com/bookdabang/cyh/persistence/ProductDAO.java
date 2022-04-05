package com.bookdabang.cyh.persistence;

import java.util.List;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;

public interface ProductDAO {
	// 셀렉트 박스에 카테고리 VO 출력	
	public List<CategoryVO> getCategory() throws Exception;
	// 정렬 조건에 맞는 상품의 개수를 가져옴
	public int conditionProdCnt(SearchCriteria sc) throws Exception;
	// 정렬 조건에 맞는 상품의 리스트를 가져옴
	public List<ProductVO> conditionProdView(SearchCriteria sc, PagingInfo pi) throws Exception;
	// 선택된 상품을 가져옴
	public ProductVO selectProdView(String prodNo) throws Exception;
	

}
