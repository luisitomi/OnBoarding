package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;

public interface getListActivaationRangeJdbcRepository {
	List<getListActivaationRangeModel> getListActivaationRange(String datei,String datef);
}
