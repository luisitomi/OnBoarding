package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface patchVoucherByIdJdbcRepository {
	List<ResponseModel> patchVoucherById(String document,String code,Integer voucher,Integer service);
}
