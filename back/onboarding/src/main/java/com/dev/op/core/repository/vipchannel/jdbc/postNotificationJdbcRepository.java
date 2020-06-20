package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postNotificationJdbcRepository {
	List<ResponseModel> postNotification(Integer module,Integer codeUser,String document,String client,String asunt);
}
