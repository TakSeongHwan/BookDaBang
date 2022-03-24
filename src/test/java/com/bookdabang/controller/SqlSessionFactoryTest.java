package com.bookdabang.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class) // 현재 클래스가 SpringJUnit4ClassRunner 클래스와 동작
@ContextConfiguration( //root-context.xml 환경설정 파일을 찾아옴
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

public class SqlSessionFactoryTest {
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Test
	public void testSqlSessionFactory() {
		System.out.println(sqlFactory);
	}
	
	@Test
	public void testSession() {
		SqlSession ses =  sqlFactory.openSession();
		System.out.println(ses);
		
	}
}

