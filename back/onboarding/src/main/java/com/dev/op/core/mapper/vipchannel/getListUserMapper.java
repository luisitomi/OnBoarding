package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListUserModel;

public class getListUserMapper implements RowMapper<getListUserModel> {
	
	@Override
	public getListUserModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListUserModel getListUser = new getListUserModel();
		getListUser.setCode(rs.getString("codigo"));
		getListUser.setUser(rs.getString("nombre"));
		return getListUser;
	}
}
