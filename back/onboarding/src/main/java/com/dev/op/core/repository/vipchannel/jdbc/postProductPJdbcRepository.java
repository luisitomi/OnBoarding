package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postProductPJdbcRepository {
	List<ResponseModel> postProductP(Integer productId,Integer provideId,String price);
}
