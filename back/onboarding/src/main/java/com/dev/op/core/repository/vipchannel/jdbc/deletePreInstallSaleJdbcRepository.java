package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface deletePreInstallSaleJdbcRepository {
	List<ResponseModel> deletePreInstallSale(Integer detail,Integer next,String description);
}
