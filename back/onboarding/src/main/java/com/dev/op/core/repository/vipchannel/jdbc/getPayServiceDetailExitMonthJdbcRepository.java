package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitMonthModel;

public interface getPayServiceDetailExitMonthJdbcRepository {
	List<getPayServiceDetailExitMonthModel> getPayServiceDetailExitMonth(String document,String code, String user);
}
