package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPersonByIdModel;

public interface getPersonByIdJdbcRepository {

	List<getPersonByIdModel> getPersonById(String document);
}
