 package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface patchUpdatePasswordJdbcRepository {
	List<ResponseModel> patchUpdatePassword(String user,String pass);
}