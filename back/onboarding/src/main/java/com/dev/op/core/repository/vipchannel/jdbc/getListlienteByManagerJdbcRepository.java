package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;

public interface getListlienteByManagerJdbcRepository {
	List<getListlienteByManagerModel> getListlienteByManager(String manager);
}