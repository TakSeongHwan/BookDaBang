package com.bookdabang.lhs.persistence;

import java.util.List;

import com.bookdabang.common.domain.ProductVO;

public interface ChartDAO {

	public List<ProductVO> getProductSort() throws Exception;

}
