package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;

public interface getPayServiceDetailJdbcRepository {
	List<getPayServiceDetailModel> getPayServiceDetail(String document,String code, String user);
}
