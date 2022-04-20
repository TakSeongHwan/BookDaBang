package com.bookdabang.tsh.persistence;

import com.bookdabang.common.domain.Sales;

public interface SalesDAO {

	public int insertSales(Sales sale) throws Exception;
}
