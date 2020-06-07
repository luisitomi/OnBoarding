package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getUserDataModel;

public class getUserDataMapper implements RowMapper<getUserDataModel> {
	
	@Override
	public getUserDataModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getUserDataModel getUserData = new getUserDataModel();
		getUserData.setId(rs.getInt("id"));
		getUserData.setCode(rs.getInt("codigo"));
		return getUserData;
	}
}
