package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postServiceInstallJdbcRepository {
	List<ResponseModel> postServiceInstall(Integer detaiId,Integer nextId,Integer tec,String description, Integer mateId,Integer counts);
}
