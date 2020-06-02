package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListDirectionModel;

public class getListDirectionMapper implements RowMapper<getListDirectionModel> {
	
	@Override
	public getListDirectionModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListDirectionModel getListDirection = new getListDirectionModel();
		getListDirection.setId(rs.getInt("calleId"));
		getListDirection.setName(rs.getString("nombre"));
		return getListDirection;
	}
}
