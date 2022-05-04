package com.bookdabang.cyh.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.ProductQnA;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.cyh.domain.AnswerDTO;
import com.bookdabang.cyh.domain.ProdDTO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.ProdQnADTO;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.domain.deleteProdDTO;
import com.bookdabang.cyh.etc.API_InputProcess;
import com.bookdabang.ljs.persistence.LoginDAO;

@Service
public class ProductServiceImpl implements ProductService {
	@Inject
	private ProductDAO pdao;

	@Inject
	private LoginDAO ldao;

	@Override
	public List<CategoryVO> getCategory() throws Exception {
		return pdao.getCategory();

	}

	@Override
	public Map<String, Object> conditionProdView(SearchCriteria sc, int pageno) throws Exception {

		int totalPostCnt = pdao.conditionProdCnt(sc);
		PagingInfo pi = pagingProcess(pageno, totalPostCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("product", pdao.conditionProdView(sc, pi));
		map.put("pagingInfo", pi);
		return map;

	}

	@Override
	public List<ProductVO> selectProdView(List<String> checkProd) throws Exception {

		List<ProductVO> prodLst = new ArrayList<ProductVO>();
		for (String prodNo : checkProd) {
			prodLst.add(pdao.selectProdView(prodNo));
		}

		return prodLst;
	}

	@Override
	public boolean updateSelectProd(List<UpdateProdDTO> list) throws Exception {
		boolean result = true;
		for (UpdateProdDTO prod : list) {
			if (pdao.updateProd(prod) != 1) {
				result = false;
				break;
			}

		}

		return result;
	}

	@Override
	public int deleteSelectProd(List<deleteProdDTO> list, String upPath) throws Exception {

		int result = 0;
		for (deleteProdDTO dto : list) {
			deleteImage(upPath, dto.getImagePath());

			if (pdao.deleteProd(dto.getProdNo()) != 1) {
				result = 0;
				break;
			}
			result++;
		}

		return result;
	}

	@Override
	public boolean validationProdNo(String isbn) throws Exception {

		boolean result = false;
		if (pdao.validationProdNo(isbn) == 0) {
			result = true;
		}

		return result;
	}

	@Override
	public ProductVO getProdByISBN(String isbn) throws Exception {

		return pdao.selectProdView(isbn);
	}

	@Override
	public boolean insertProd(ProdDTO product) throws Exception {
		boolean result = false;
		if (pdao.insertProd(product) == 1) {
			result = true;
		}

		return result;
	}

	@Override
	public ProdInfo viewInfoByIsbn(String isbn) throws Exception {
		API_InputProcess api = new API_InputProcess();
		return api.apiInput(isbn);

	}

	@Override
	public void deleteImage(String upPath, String imagePath) throws Exception {

		if (imagePath.contains("http")) {
			return;
		} else {
			String deletePath = imagePath.split("uploads")[1];
			System.out.println(deletePath);
			System.out.println(upPath + deletePath.replace("/", File.separator));
			File delFile = new File(upPath + deletePath.replace("/", File.separator));
			delFile.delete();
		}

	}
	
	
	@Override
	public boolean updateProd(ProdDTO product) throws Exception {
		boolean result = false; 
			if(pdao.updateProd(product) ==1) {
				result = true;
			}
		return result;
	}
	
	

//========================= QnA ===================================================

	

	@Override
	public boolean insertAnswer(AnswerDTO answer) throws Exception {
		boolean result = false;
		String pwd = pdao.getPwdByQuesNo(answer.getQuestion_no());

		if (pwd != null) {
			answer.setPwd(pwd);
		}

		System.out.println(answer.toString());
		if (pdao.insertAnswer(answer) == 1) {
			if (pdao.updateAnserStatus(answer) == 1) {
				result = true;
			}
		}

		return result;
	}

	@Override
	public String validSession(String sessionId) throws Exception {
		MemberVO member = ldao.findLoginSess(sessionId);
		return member.getNickName();
	}

	@Override
	public boolean InsertQnA(ProdQnADTO dto) throws Exception {

		boolean result = false;
		MemberVO member = ldao.findLoginSess(dto.getWriter());
		dto.setRef(pdao.getMaxquestionNo() + 1);
		System.out.println(dto.getRef());
		dto.setWriter(member.getNickName());

		if (pdao.InsertQnA(dto) == 1) {
			result = true;
		}

		return result;
	}

	@Override
	public Map<String, Object> selectProdQnA(int pageNo, int answerStatus, String isbn) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ProductQnA> list = null;
		int totalPostCnt = 0;
		PagingInfo pi = null;

		// 응답 안된 QnA
		if (answerStatus == 1) {
			totalPostCnt = pdao.getQnaCntofnotAnswer();
			pi = pagingProcess(pageNo, totalPostCnt);
			list = pdao.selectAllProdQnA_NoAnswer(pi);
			// 응답이 된 QnA
		} else if (answerStatus == 2) {
			totalPostCnt = pdao.getQnaCntofAnswer();
			pi = pagingProcess(pageNo, totalPostCnt);
			list = pdao.selectAllProdQnA_Answer(pi);
			// isbn 조회
		} else {
			if (isbn != "1") {
				totalPostCnt = pdao.getQnaCnt(isbn);
				pi = pagingProcess(pageNo, totalPostCnt);
				list = pdao.selectProdQnAByISBN(pi, isbn);
			}
		}

		map.put("pagingInfo", pi);
		map.put("qnaList", list);

		return map;

	}

	@Override
	public boolean deleteQnA(int questionNo) throws Exception {
		boolean result = false;
		if (pdao.deleteQnA(questionNo) > 0) {
			result = true;
		}

		return result;
	}

	// ========================= etc =================================

	private PagingInfo pagingProcess(int pageNo, int totalPostCnt) throws Exception {
		PagingInfo pi = new PagingInfo();
		pi.setPostPerPage(10);
		pi.setPageCntPerBlock(5);

		pi.setTotalPostCnt(totalPostCnt);

		pi.setTotalPage(pi.getTotalPostCnt());

		pi.setStartNum(pageNo);

		pi.setTotalPagingBlock(pi.getTotalPage());

		pi.setCurrentPagingBlock(pageNo);

		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());

		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());

		System.out.println(pi.toString());

		return pi;

	}

}
