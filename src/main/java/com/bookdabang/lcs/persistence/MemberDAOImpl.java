/**
 * 
 */
package com.bookdabang.lcs.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.lcs.domain.MemberDTO;



@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sql;
	private static String ns = "com.bookdabang.mapper.memberMapper";
	@Override
	public int insertMember(MemberDTO member) throws Exception {

		return sql.insert(ns + ".insertMember", member);
	}
	@Override
	public MemberVO userIdCheck(String userId) throws Exception {
		
		return sql.selectOne(ns + ".userIdCheck", userId);
	}
	@Override
	public MemberVO nickNameCheck(String nickName) throws Exception {

		return sql.selectOne(ns + ".nickNameCheck", nickName);
	}
	@Override
	public int insertPoint(MemberPoint point) throws Exception {
		
		return sql.insert(ns + ".insertPoint", point);
	}
	



}
