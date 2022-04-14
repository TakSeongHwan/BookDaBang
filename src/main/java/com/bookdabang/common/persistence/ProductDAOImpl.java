package com.bookdabang.common.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.ProdQnADTO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	private SqlSession ses; // SqlSessionTemplete 객체 주입

	private static String ns = "com.bookdabang.mapper.productMapper"; // mapper의 namespace
	
	// 최윤호

	@Override
	public List<CategoryVO> getCategory() throws Exception {
		return ses.selectList(ns + ".getCategory");
	}

	@Override
	public int conditionProdCnt(SearchCriteria sc) throws Exception {
		return ses.selectOne(ns + ".conditionProdCnt", sc);
	}

	@Override
	public List<ProductVO> conditionProdView(SearchCriteria sc, PagingInfo pi) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("searchType", sc.getSearchType());
		param.put("searchWord", sc.getSearchWord());
		param.put("category_code", sc.getCategory_code());
		param.put("startNum", pi.getStartNum());
		param.put("postPerPage", pi.getPostPerPage());
		param.put("sortWord", sc.getSortWord());
		param.put("sortMethod", sc.getSortMethod());
		param.put("startRgDate", sc.getStartRgDate());
		param.put("endRgDate", sc.getEndRgDate());
		param.put("startUpdate", sc.getStartUpdate());
		param.put("endUpdate", sc.getEndUpDate());
		param.put("start_endDate", sc.getStart_endDate());
		param.put("end_endDate", sc.getEnd_endDate());
		param.put("display_status", sc.getDisplay_status());
		param.put("sales_status", sc.getSales_status());
		return ses.selectList(ns + ".conditionProdView", param);
	}

	@Override
	public ProductVO selectProdView(String isbn) throws Exception {

		return ses.selectOne(ns + ".selectProdView", isbn);
	}

	@Override
	public int updateProd(UpdateProdDTO prod) throws Exception {

		return ses.update(ns + ".updateProd", prod);
	}

	@Override
	public int validationProdNo(String prodNo) throws Exception {
		
		return ses.selectOne(ns + ".validationProdNo", prodNo);
	}
	
	

	@Override
	public int insertAnswer(AnswerDTO answer) {
		
		return ses.insert(ns + ".insertAnswer", answer);
	}
	
	
	@Override
	public int updateAnserStatus(AnswerDTO answer) {
		return ses.update(ns + ".updateAnserStatus", answer);
	}
	
	

	//========================= QnA ===================================================
	
	
	@Override
	public int getMaxquestionNo() throws Exception {
		
		return ses.selectOne(ns + ".getMaxquestionNo");
	}
	

	@Override
	public int InsertQnA(ProdQnADTO dto) throws Exception {
		
		return ses.insert(ns + ".insertProdQnA", dto);
	}
	
//	==================================(count)=============================================

	@Override
	public int getQnaCnt(String isbn) throws Exception {
	
		return ses.selectOne(ns + ".getQnaCntByISBN",isbn);
	}
	@Override
	public int getQnaCntofnotAnswer() {
		
		return ses.selectOne(ns + ".getQnaCntofnotAnswer");
	}

	@Override
	public int getQnaCntofAnswer() throws Exception {
		
		return ses.selectOne(ns + ".getQnaCntofAnswer");
	}
//	==================================(list)==============================================

	@Override
	public List<ProductQnA> selectProdQnAByISBN(PagingInfo pi, String isbn) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("isbn", isbn);
		map.put("startNum", pi.getStartNum());
		map.put("postPerPage", pi.getPostPerPage());
		
		return ses.selectList(ns + ".selectProdQnAByISBN", map);
	}
	
	@Override
	public List<ProductQnA> selectAllProdQnA_NoAnswer(PagingInfo pi) {
		
		return ses.selectList(ns + ".selectAllProdQnA_NoAnswer", pi);
	}
	@Override
	public List<ProductQnA> selectAllProdQnA_Answer(PagingInfo pi) {
		
		return ses.selectList(ns + ".selectAllProdQnA_Answer", pi);
	}
	
	
	@Override
	public int deleteQnA(int questionNo) {
		
		return ses.delete(ns + ".deleteQnA", questionNo);
	}
	
	
	
	

	// 강명진
	

	@Override
	public List<ProductVO> selectAllProducts(PagingInfo pi,int sort) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("startNum", pi.getStartNum());
		param.put("postPerPage", pi.getPostPerPage());
		param.put("sort", sort);
		return ses.selectList(ns + ".selectAllProducts",param);
	}
	
	@Override
	public List<ProductVO> selectAllProducts(int cno,PagingInfo pi,int sort) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("cno", cno);
		param.put("startNum", pi.getStartNum());
		param.put("postPerPage", pi.getPostPerPage());
		param.put("sort", sort);
		return ses.selectList(ns + ".selectProductsByCategory",param);
	}
	
	@Override
	public List<CategoryVO> selectCategory() throws Exception {
		return ses.selectList(ns + ".selectCategory");
	}
	
	@Override
	public int getTotalPost() throws Exception {
		return ses.selectOne(ns + ".getTotalPost");
	}
	
	@Override
	public int getTotalPost(int cno) throws Exception {
		return ses.selectOne(ns + ".getTotalPostByCategory",cno);
	}

	@Override
	public ProductVO selectProduct(int prodNo) throws Exception {
		return ses.selectOne(ns + ".selectProduct", prodNo);
	}

	@Override
	public List<ProductVO> selectTopProducts(int category) throws Exception {
		return ses.selectList(ns + ".selectTopProducts", category);
	}

}
