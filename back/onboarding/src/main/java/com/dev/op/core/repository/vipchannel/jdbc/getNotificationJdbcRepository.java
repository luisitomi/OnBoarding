package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getNotificationModel;

public interface getNotificationJdbcRepository {
	List<getNotificationModel> getNotification(String user);
}
