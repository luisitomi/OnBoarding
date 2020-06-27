package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postServiceReclaimJdbcRepository {
	List<ResponseModel> postServiceReclaim(Integer detaiId,Integer tec,String description, Integer mateId,Integer counts);
}
