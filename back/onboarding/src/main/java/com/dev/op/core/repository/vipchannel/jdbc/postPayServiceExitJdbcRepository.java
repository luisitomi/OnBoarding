package com.dev.op.core.repository.vipchannel.jdbc;

import java.math.BigDecimal;
import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postPayServiceExitJdbcRepository {
	List<ResponseModel> postPayServiceExit(String document,String code,BigDecimal amount,Integer user, Integer managerId,Integer type, Integer serviceSelect);
}
