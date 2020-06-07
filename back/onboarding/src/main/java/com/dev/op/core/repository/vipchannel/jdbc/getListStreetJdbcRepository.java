package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListStreetModel;

public interface getListStreetJdbcRepository {
	List<getListStreetModel> getListStreet(Integer distric);
}
