package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListServiceNotActiveModel;

public interface getListServiceNotActiveJdbcRepository {
	List<getListServiceNotActiveModel> getListServiceNotActive(String document,String code);
}
