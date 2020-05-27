package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface patchManagerByIdJdbcRepository {
	List<ResponseModel> patchManagerById(String document,String code,Integer code_manager);
}
