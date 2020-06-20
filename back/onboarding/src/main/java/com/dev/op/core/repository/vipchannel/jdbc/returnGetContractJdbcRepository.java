package com.dev.op.core.repository.vipchannel.jdbc;


import com.dev.op.core.dto.vipchannel.returnGetContractModel;

public interface returnGetContractJdbcRepository {
	returnGetContractModel returnGetContract(Integer detailId,Integer nextId);
}
