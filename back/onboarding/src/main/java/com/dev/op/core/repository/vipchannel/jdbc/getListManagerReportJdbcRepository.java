package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListManagerReportModel;

public interface getListManagerReportJdbcRepository {
	List<getListManagerReportModel> getListManagerReport(Integer manager);
}
