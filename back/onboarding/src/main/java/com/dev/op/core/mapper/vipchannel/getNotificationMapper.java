package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getNotificationModel;

public class getNotificationMapper implements RowMapper<getNotificationModel> {
	
	@Override
	public getNotificationModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getNotificationModel getNotification = new getNotificationModel();
		getNotification.setId(rs.getInt("tareaId"));
		getNotification.setUser(rs.getString("nombre"));
		getNotification.setPending(rs.getString("asunto"));
		getNotification.setClient(rs.getString("client"));
		getNotification.setAsign(rs.getString("asign"));
		return getNotification;
	}
}
