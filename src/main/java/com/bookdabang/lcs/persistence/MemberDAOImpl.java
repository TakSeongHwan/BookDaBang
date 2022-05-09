/**
 * 
 */
package com.bookdabang.lcs.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.MemberPoint;
import com.bookdabang.common.domain.MemberVO;
import com.bookdabang.common.domain.PagingInfo;
import com.bookdabang.common.domain.Withdraw;
import com.bookdabang.lcs.domain.IsdormantDTO;
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
	@Override
	public List<MemberVO> selectMember(PagingInfo pi) throws Exception {
	
		return sql.selectList(ns + ".selectMember", pi);
	}
	@Override
	public List<MemberVO> dormantMember(PagingInfo pi) throws Exception {
		
		return sql.selectList(ns + ".dormantMember", pi);
	}
	@Override
	public List<Withdraw> deleteMember(PagingInfo pi) throws Exception {
		
		return sql.selectList(ns + ".deleteMember", pi);
	}

	@Override
	public int updatedormant(IsdormantDTO dormant) throws Exception {
//		Map<String, String> updatedm = new HashMap<String, String>();
//		updatedm.put("dorment", dorment);
//		updatedm.put("userId", userId);
		return sql.update(ns + ".isdormant", dormant);

	}
	@Override
	public int delete(String userId) throws Exception {
		return sql.delete(ns +".delete", userId);
		
	}
	@Override
	public int getTotalPost(PagingInfo paging) throws Exception {
		return sql.selectOne(ns+".getTotalPost", paging);
	}
	@Override
	public int getTotalPostOfDormant(PagingInfo paging) throws Exception {
		return sql.selectOne(ns+".getTotalPostOfDormant", paging);
	}
	@Override
	public int getTotalPostOfDelete(PagingInfo paging) throws Exception {
		return sql.selectOne(ns+".getTotalPostOfDelete", paging);
	}




}
