package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getListReclaimServiceModel;

public interface getListReclaimServiceJdbcRepository {
	List<getListReclaimServiceModel> getListReclaimService(Integer codeint);
}
