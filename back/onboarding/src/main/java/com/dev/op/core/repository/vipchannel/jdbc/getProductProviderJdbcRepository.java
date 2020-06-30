package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getProductProviderModel;

public interface getProductProviderJdbcRepository {
	List<getProductProviderModel> getProductProvider(Integer optio,Integer productoE);
}
