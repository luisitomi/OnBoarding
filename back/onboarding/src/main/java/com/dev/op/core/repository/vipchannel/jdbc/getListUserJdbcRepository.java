package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListUserModel;

public interface getListUserJdbcRepository {
	List<getListUserModel> getListUser(Integer codeUser);
}
