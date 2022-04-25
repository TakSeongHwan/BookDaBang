package com.bookdabang.cyh.service;

import java.util.List;
import java.util.Map;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.InsertProdDTO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.ProdQnADTO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.domain.deleteProdDTO;

public interface ProductService {
	public List<CategoryVO> getCategory() throws Exception;

	public Map<String, Object> conditionProdView(SearchCriteria sc, int pageno) throws Exception;

	public List<ProductVO> selectProdView(List<String> checkProd) throws Exception;

	public boolean updateSelectProd(List<UpdateProdDTO> list) throws Exception;
	
	public int deleteSelectProd(List<deleteProdDTO> list, String upPath) throws Exception;

	public boolean validationProdNo(String isbn) throws Exception;
	
	public ProductVO getProdByISBN(String isbn) throws Exception;

	public ProdInfo viewInfoByIsbn(String isbn) throws Exception;
	
	public boolean insertProd(InsertProdDTO product) throws Exception;

	public void deleteImage(String upPath, String deletePath) throws Exception;

	public boolean insertAnswer(AnswerDTO answer) throws Exception;

//	QnA
	// sessionId로 member 찾기
	public String validSession(String sessionId) throws Exception;

	public boolean InsertQnA(ProdQnADTO dto) throws Exception;

	public Map<String, Object> selectProdQnA(int pageno, int answerStatus, String isbn) throws Exception;


	public boolean deleteQnA(int questionNo) throws Exception;

	

}
