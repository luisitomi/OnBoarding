package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postSaveServiceSaleJdbcRepository {
	List<ResponseModel> postSaveServiceSale(String document,
			String code,
			String name,
			String last,
			String second,
			String client,
			String fech,
			String email,
			Integer zone,
			String number,
			String descriptionrefe,
			Integer seller,
			String fechadate,
			String timedate,
			Integer servicecount,
			String amountfirst,
			String amountsecond,
			String textins);
}
