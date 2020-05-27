package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putPersonByIdJdbcRepository {
	List<ResponseModel> putPersonById(String document,String name,String last,String second,String client);
}
