package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putReferenceByIdJdbcRepository {
	List<ResponseModel> putReferenceById(String document,String code,String description);
}
