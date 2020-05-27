package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getManagaerCountModel;

public interface getManagaerCountJdbcRepository {
	List<getManagaerCountModel> getManagaerCount(String con);
}
