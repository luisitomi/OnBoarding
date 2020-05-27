package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;

public interface getPayServiceDetailMonthJdbcRepository {
	List<getPayServiceDetailMonthModel> getPayServiceDetailMonth(String document,String code, String user);
}
