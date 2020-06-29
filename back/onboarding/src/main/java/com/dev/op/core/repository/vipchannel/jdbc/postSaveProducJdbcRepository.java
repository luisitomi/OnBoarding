package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postSaveProducJdbcRepository {
	List<ResponseModel> postSaveProduc(String name,String code,String description,String codeP,String medi);
}
