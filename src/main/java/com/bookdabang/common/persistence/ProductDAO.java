package com.bookdabang.common.persistence;

import java.util.List;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.ProdDTO;
import com.bookdabang.cyh.domain.ProdQnADTO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;

public interface ProductDAO {
	
	// 최윤호
	
	// 셀렉트 박스에 카테고리 VO 출력	
	public List<CategoryVO> getCategory() throws Exception;
	// 정렬 조건에 맞는 상품의 개수를 가져옴
	public int conditionProdCnt(SearchCriteria sc) throws Exception;
	// 정렬 조건에 맞는 상품의 리스트를 가져옴
	public List<ProductVO> conditionProdView(SearchCriteria sc, PagingInfo pi) throws Exception;
	// 선택된 상품을 가져옴
	public ProductVO selectProdView(String prodNo) throws Exception;
	// 선택된 상품 하나를 업데이트 (일괄)
	public int updateProd(UpdateProdDTO prod) throws Exception;
	
	// 선택된 상품 하나를 업데이트 	
	public int updateProd(ProdDTO prod) throws Exception;
	// 선택된 상품 하나를 삭제 (일괄)
	public int deleteProd(String isbn) throws Exception;
	
	public int insertProd(ProdDTO product) throws Exception;
	// isbn(상품번호) 유효성 확인
	public int validationProdNo(String prodNo) throws Exception;
	
	// 글번호로 qna 비밀번호 가져옴
	public String getPwdByQuesNo(int question_no);
	// 글번호로 QnA 정보 가져옴
	public ProductQnA getQnAByquesNo(int question_no);
	// 답글 insert
	public int insertAnswer(AnswerDTO answer);
	// Qna isnert
	public int getMaxquestionNo() throws Exception;
	public int InsertQnA(ProdQnADTO dto) throws Exception;
	public int updateAnserStatus(AnswerDTO answer);
	
	// qna count
	public int getQnaCnt(String isbn) throws Exception;
	public int getQnaCntofnotAnswer() throws Exception;
	public int getQnaCntofAnswer() throws Exception;
	
	
	//전체 qna 가져옴 (answerStatus == 1,2,3)
	public List<ProductQnA> selectProdQnAByISBN(PagingInfo pi, String isbn) throws Exception;
	public List<ProductQnA> selectAllProdQnA_NoAnswer(PagingInfo pi) throws Exception;
	public List<ProductQnA> selectAllProdQnA_Answer(PagingInfo pi) throws Exception;
	
	
	//QnA Update
	public int updateQnA(AnswerDTO prodQnA);
	
	//qna 삭제
	public int deleteQnA(int questionNo);
	
	
	
	
	// 강명진
	
	// 전체 상품 가져오는 메서드 (카테고리,정렬,검색어 포함)
	public List<ProductVO> selectAllProducts (int cno,PagingInfo pi,int sort,String searchWord) throws Exception;
	
	// 카테고리 정보 가져오는 메서드 (검색어 포함)
	public List<CategoryVO> selectCategory(String searchWord) throws Exception;
	
	// 전체 상품의 개수 가져오기 (카데고리,검색어 포함)
	public int getTotalPost(int cno,String searchWord) throws Exception;
	
	// 한 상품 가져오는 메서드
	public ProductVO selectProduct (int prodNo) throws Exception;
	
	// Top 상품 가져오는 메서드
	public List<ProductVO> selectTopProducts (int cno) throws Exception;
	
	// Top 상품 가져오는 메서드
	public List<ProductVO> selectTopProducts (String searchWord) throws Exception;
	
	
}
