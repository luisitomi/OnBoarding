package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postReclaimByIdJdbcRepository {
	List<ResponseModel> postReclaimById(String document,String code,Integer service,Integer reclaim,String description);
}
