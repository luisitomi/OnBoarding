package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putTecnInstallJdbcRepository {
	List<ResponseModel> putTecnInstall(Integer optionI,Integer tecn,Integer idP,Integer nextId);
}
