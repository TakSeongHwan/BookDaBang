package com.bookdabang.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookdabang.tsh.persistence.CartDAO;
import com.bookdabang.tsh.persistence.TestDAO;

@RunWith(SpringJUnit4ClassRunner.class) // 현재 클래스가 SpringJUnit4ClassRunner 클래스와 동작
@ContextConfiguration( //root-context.xml 환경설정 파일을 찾아옴
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DAOTest {
	@Inject
	private CartDAO dao;

	@Test
	public void getMember() throws Exception {
		System.out.println(dao.getCartByUserId("cow")); 
	}

}
