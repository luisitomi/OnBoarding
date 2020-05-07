package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;

public interface getVoucherByIdJdbcRepository {
	List<getVoucherByIdModel> getVoucherById(String document,String code);
}
