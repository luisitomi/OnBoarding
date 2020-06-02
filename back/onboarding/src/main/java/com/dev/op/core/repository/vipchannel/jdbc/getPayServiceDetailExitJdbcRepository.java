package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitModel;

public interface getPayServiceDetailExitJdbcRepository {
	List<getPayServiceDetailExitModel> getPayServiceDetailExit(String document,String code, String user);
}
