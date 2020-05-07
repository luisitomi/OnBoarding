package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;

public interface getDirectionByIdJdbcRepository {

	List<getDirectionByIdModel> getDirectionById(String document,String code);
}
