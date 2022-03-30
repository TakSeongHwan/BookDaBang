package com.bookdabang.tsh.service;

import com.bookdabang.common.domain.AddressVO;

public interface AddressService {
	
	public AddressVO selectUserAddress(String userId) throws Exception;
	
	public int insertAddress(AddressVO address) throws Exception;
	
	public int updateAddress(AddressVO address) throws Exception;
	

}
