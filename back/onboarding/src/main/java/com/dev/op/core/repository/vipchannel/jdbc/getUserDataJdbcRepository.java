package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getUserDataModel;

public interface getUserDataJdbcRepository {
	List<getUserDataModel> getUserData(String user,String pass);
}
