package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getNameUserModel;

public class getNameUserMapper implements RowMapper<getNameUserModel> {
	
	@Override
	public getNameUserModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getNameUserModel getNameUser = new getNameUserModel();
		getNameUser.setName(rs.getString("nombre"));
		return getNameUser;
	}
}
