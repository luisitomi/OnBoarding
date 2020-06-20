package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getDetailContractModel;

public interface getDetailContractJdbcRepository {
	List<getDetailContractModel> getDetailContract(Integer detailId,Integer nextId);
}
