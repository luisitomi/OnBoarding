package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListSubModuleModel;

public interface getListSubModuleJdbcRepository {
	List<getListSubModuleModel> getListSubModule(String user);
}
