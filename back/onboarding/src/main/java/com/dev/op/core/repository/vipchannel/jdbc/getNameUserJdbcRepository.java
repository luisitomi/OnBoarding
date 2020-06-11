package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getNameUserModel;

public interface getNameUserJdbcRepository {
	List<getNameUserModel> getNameUser(String user);
}
