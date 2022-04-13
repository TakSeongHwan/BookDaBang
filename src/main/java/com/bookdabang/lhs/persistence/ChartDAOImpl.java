package com.bookdabang.lhs.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.ProductVO;
import com.bookdabang.common.domain.VisitorIPCheck;
import com.bookdabang.lhs.domain.VisitorCountWithDateFormat;

@Repository
public class ChartDAOImpl implements ChartDAO {
	@Inject
	private SqlSession ses;

	private static String ns = "com.bookdabang.mapper.ChartMapper";
	
	@Override
	public List<ProductVO> getProductSort() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getSalesCount");
	}

	@Override
	public List<ProductVO> getRandomSelect() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getRandomBook");
	}

	@Override
	public List<VisitorCountWithDateFormat> getVisitorInfo() throws Exception {
		// TODO Auto-generated method stub
		return ses.selectList(ns+".getVisitorInfo");
	}

	@Override
	public int autoInsertVisitor(VisitorIPCheck vipc) throws Exception {
		// TODO Auto-generated method stub
		return ses.insert(ns+".autoInsertVisitor",vipc);
	}
	
	
}
