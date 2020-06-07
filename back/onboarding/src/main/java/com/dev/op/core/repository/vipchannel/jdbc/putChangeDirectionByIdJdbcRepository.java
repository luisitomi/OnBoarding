package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putChangeDirectionByIdJdbcRepository {
	List<ResponseModel> putChangeDirectionById(String document,String code,String number,Integer zone,String reference);
}
