package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;

public interface getReferenceByIdJdbcRepository {
	List<getReferenceByIdModel> getReferenceById(String document,String code);
}
