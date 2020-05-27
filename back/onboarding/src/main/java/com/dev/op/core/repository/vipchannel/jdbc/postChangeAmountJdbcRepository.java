package com.dev.op.core.repository.vipchannel.jdbc;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postChangeAmountJdbcRepository {
	List<ResponseModel> postChangeAmount(String document,String code,Integer service,BigDecimal amount,Date dateformat,Integer user);
}
