package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListCountOnuModel;

public interface getListCountOnuJdbcRepository {
	List<getListCountOnuModel> getListCountOnu(Integer detalleIds,Integer nextids);
}
