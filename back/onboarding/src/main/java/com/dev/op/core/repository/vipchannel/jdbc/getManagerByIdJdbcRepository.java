package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getManagerByIdModel;

public interface getManagerByIdJdbcRepository {
	List<getManagerByIdModel> getManagerById(String document,String code);
}
