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
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.cyh.domain.ProdInfo;
import com.bookdabang.cyh.domain.SearchCriteria;
import com.bookdabang.cyh.domain.UpdateProdDTO;
import com.bookdabang.cyh.etc.API_InputProcess;

@Service
public class ProductServiceImpl implements ProductService {
	@Inject
	private ProductDAO pdao;

	@Override
	public List<CategoryVO> getCategory() throws Exception {
		return pdao.getCategory();

	}

	@Override
	public Map<String, Object> conditionProdView(SearchCriteria sc, int pageno) throws Exception {
		PagingInfo pi = pagingProcess(pageno, sc);
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
	public boolean validationProdNo(String isbn) throws Exception {

		boolean result = false;
		if (pdao.validationProdNo(isbn) == 0) {
			result = true;
		}
		;

		return result;
	}

	@Override
	public ProdInfo viewInfoByIsbn(String isbn) throws Exception {
		API_InputProcess api = new API_InputProcess();
		return api.apiInput(isbn);

	}

	@Override
	public void deleteImage(String upPath, String deletePath) throws Exception {
		System.out.println(upPath + deletePath.replace("/", File.separator));
		File delFile = new File(upPath + deletePath.replace("/", File.separator));

		delFile.delete();

	}

	private PagingInfo pagingProcess(int pageNo, SearchCriteria sc) throws Exception {
		PagingInfo pi = new PagingInfo();
		pi.setPostPerPage(10);
		pi.setPageCntPerBlock(5);

		int totalPostCnt = pdao.conditionProdCnt(sc);

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

//========================= QnA ===================================================
	@Override
	public String validSession(String sessionId) throws Exception {
		MemberVO member =pdao.validSession(sessionId);

		return member.getUserId();
	}

}
