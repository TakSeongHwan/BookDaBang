package com.bookdabang.common.persistence;

import java.util.List;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.SearchCriteria;

public interface ProductDAO {
	// 최윤호
	
	public List<CategoryVO> getCategory() throws Exception;
	public int conditionProdCnt(SearchCriteria sc) throws Exception;
	public List<ProductVO> conditionProdView(SearchCriteria sc, PagingInfo pi) throws Exception;
	public ProductVO selectProdView(String prodNo) throws Exception;
	
	
	// 강명진
	
	// 전체 상품 가져오는 메서드
	public List<ProductVO> selectAllProducts (PagingInfo pi,int sort) throws Exception;
	
	// 카테고리 정보 가져오는 메서드
	public List<CategoryVO> selectCategory() throws Exception;
	
	// 전체 상품 가져오는 메서드 (카테고리 번호가 있을 경우)
	public List<ProductVO> selectAllProducts (int cno,PagingInfo pi,int sort) throws Exception;
	
	// 전체 상품의 개수 가져오기
	public int getTotalPost() throws Exception;
	
	// 전체 상품의 개수 가져오기 (카테고리 번호가 있을 경우)
	public int getTotalPost(int cno) throws Exception;
	
	// 전체 카테고리 가져오는 메서드 - getCategory() 이용
	
	// 한 상품 가져오는 메서드
	public ProductVO selectProduct (int prodNo) throws Exception;
	
	// Top 상품 가져오는 메서드
	public List<ProductVO> selectTopProducts (int category) throws Exception;
}
