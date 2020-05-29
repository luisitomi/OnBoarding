package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteMonthModel;

public interface getPayServiceDetailDeleteMonthJdbcRepository {
	List<getPayServiceDetailDeleteMonthModel> getPayServiceDetailDeleteMonth(String document,String code);
}
