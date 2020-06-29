package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postRemisionJdbcRepository {
	List<ResponseModel> postRemision(Integer options,Integer typeRemi,Integer producId,Integer providerId,Integer counts,String conditions,String autorize,Integer codeuser);
}
