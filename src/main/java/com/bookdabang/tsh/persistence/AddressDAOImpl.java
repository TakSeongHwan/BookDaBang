package com.bookdabang.tsh.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.bookdabang.common.domain.AddressVO;

@Repository
public class AddressDAOImpl implements AddressDAO {
	@Inject
	private SqlSession ses;
	
	private String ns = "com.bookdabang.mapper.AddressMapper";

	@Override
	public AddressVO selectUserAddress(String userId) throws Exception {
		return ses.selectOne(ns+".selectUserAddress", userId);
	}

	@Override
	public int insertAddress(AddressVO address) throws Exception {
		return ses.insert(ns+".insertAddress", address);
	}

	@Override
	public int updateAddress(AddressVO address) throws Exception {
		return ses.update(ns+".updateAddress", address);
	}

	@Override
	public int nextAddressNo() throws Exception {
		if(ses.selectOne(ns+".nextAddressNo") == null) {
			return 1;
		}
		return ses.selectOne(ns+".nextAddressNo");
	}
	
	
}
