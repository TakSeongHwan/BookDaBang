package com.bookdabang.kmj.service;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.bookdabang.common.domain.CategoryVO;
import com.bookdabang.common.domain.PageView;
import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.persistence.ProductDAO;
import com.bookdabang.common.domain.PagingInfo;

@Service
public class UserProductServiceImpl implements UserProductService {
	
	@Inject
	private ProductDAO dao;
	
	@Override
	public Map<String, Object> readAllProducts(int cno, int pageNo, int sort, String searchWord) throws Exception {
		PagingInfo pi = pagingProcess(pageNo,cno,searchWord);
		
		List<ProductVO> lst = dao.selectAllProducts(cno,pi,sort,searchWord);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productList", lst);
		map.put("pagingInfo", pi);
		
		return map;
	}
	
	// 페이징 처리 작업 전담 메서드
	private PagingInfo pagingProcess(int pageNo, int cno,String searchWord) throws Exception {
		PagingInfo pi = new PagingInfo();
		
		// 1페이지당 보여 줄 글의 개수 & 1개의 블럭에 보여줄 페이지 수
		pi.setPostPerPage(9);
		pi.setPageCntPerBlock(5);
		
		// 전체 게시물 개수
		pi.setTotalPostCnt(dao.getTotalPost(cno,searchWord));
		
		// 전체 페이지 수
		pi.setTotalPage(pi.getTotalPostCnt());
		// 현재 페이지에서 출력 시작할 글번호
		pi.setStartNum(pageNo);
		// 전체 페이징 블럭
		pi.setTotalPagingBlock(pi.getTotalPage());
		// 현재 페이징 블럭
		pi.setCurrentPagingBlock(pageNo);
		// 현재 페이지에서의 시작 페이징블럭
		pi.setStartNoOfCurPagingBlock(pi.getCurrentPagingBlock());
		// 현재 페이지에서의 끝 페이징블럭
		pi.setEndNoOfCurPagingBlock(pi.getStartNoOfCurPagingBlock());

		System.out.println(pi.toString());

		return pi;
	}
	
	@Override
	public List<CategoryVO> readAllCategory(String searchWord) throws Exception {
		List<CategoryVO> lst = dao.selectCategory(searchWord);
		return lst;
	}

	@Override
	public ProductVO readProduct(int prodNo) throws Exception {
		ProductVO product = dao.selectProduct(prodNo);
		return product;
	}

	@Override
	public List<ProductVO> readTopProducts(int cno,String searchWord) throws Exception {
		List<ProductVO> lst = null;
		if (cno == 0) {
			lst = dao.selectTopProducts(searchWord);
		} else {
			lst = dao.selectTopProducts(cno);
		}
		
		return lst;
	}

	@Override
	public boolean addProductView(int prodNo,String ipaddr) throws Exception {
		boolean result = false;
		
		PageView pageview = dao.selectPageview(prodNo,ipaddr);
		
		if(pageview != null) {
			
			long lastAccessDate = pageview.getAccessDate().getTime();
			long currTime = System.currentTimeMillis();
			
			System.out.println("이전 기록 : " + lastAccessDate);
			System.out.println("현재 시간 : " + currTime);
			
			if(currTime - lastAccessDate > 1000 * 60 *60*24) {
				if(dao.updatePageview(prodNo,ipaddr) == 1) {
					if (dao.updateReadCount(prodNo) == 1) {
						System.out.println("조회기록 갱신");
						result = true;
					}
				}
			} else {
				result = true;
				System.out.println("이전 조회기록 하루 안 지남");
			}
		}else {
			
			if(dao.insertPageview(prodNo,ipaddr) == 1) {
				if (dao.updateReadCount(prodNo) == 1) {
					System.out.println("조회기록 추가");
					result = true;
				}
			}
			
		}
		return result;
	}

	@Override
	public String getCategoryName(int cno) throws Exception {
		String categoryName = dao.selectCategoryName(cno);
		
		return categoryName;
	}


}
