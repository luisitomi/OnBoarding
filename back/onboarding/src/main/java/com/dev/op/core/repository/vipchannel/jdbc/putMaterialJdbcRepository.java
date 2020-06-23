package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putMaterialJdbcRepository {
	List<ResponseModel> putMaterial(String name,Integer idMaterial);
}
