package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListPayModel;

public interface getListPayJdbcRepository {
	List<getListPayModel> getListPay(Integer user,String explicite);
}
