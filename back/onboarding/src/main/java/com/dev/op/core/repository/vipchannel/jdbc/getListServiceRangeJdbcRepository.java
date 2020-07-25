package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListServiceRangeModel;

public interface getListServiceRangeJdbcRepository {
	List<getListServiceRangeModel> getListServiceRange(String datei,String datef);
}
