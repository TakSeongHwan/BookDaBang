package com.bookdabang.tsh.persistence;

import com.bookdabang.common.domain.AddressVO;

public interface AddressDAO {
	
	public AddressVO selectUserAddress(String userId) throws Exception;
	
	public int insertAddress(AddressVO address) throws Exception;
	
	public int updateAddress(AddressVO address) throws Exception;

	public int nextAddressNo() throws Exception;
}
