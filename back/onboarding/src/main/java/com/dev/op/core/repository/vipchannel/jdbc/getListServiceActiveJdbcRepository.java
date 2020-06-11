package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;

public interface getListServiceActiveJdbcRepository {
	List<getListServiceActiveModel> getListServiceActive(String document,String code);
}
