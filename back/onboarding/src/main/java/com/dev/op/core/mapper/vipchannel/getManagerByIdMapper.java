package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getManagerByIdModel;

public class getManagerByIdMapper implements RowMapper<getManagerByIdModel> {
	
	@Override
	public getManagerByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getManagerByIdModel getManagerById = new getManagerByIdModel();
		getManagerById.setManager(rs.getString("manager"));
		getManagerById.setDocument(rs.getString("documentManager"));
		return getManagerById;
	}
}
