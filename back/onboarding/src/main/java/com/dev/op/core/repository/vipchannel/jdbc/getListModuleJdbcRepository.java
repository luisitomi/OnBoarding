package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListModuleModel;

public interface getListModuleJdbcRepository {
	List<getListModuleModel> getListModule(String user);
}
