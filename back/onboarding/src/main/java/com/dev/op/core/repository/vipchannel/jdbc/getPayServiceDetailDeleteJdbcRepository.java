package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteModel;

public interface getPayServiceDetailDeleteJdbcRepository {
	List<getPayServiceDetailDeleteModel> getPayServiceDetailDelete(String document,String code);
}
