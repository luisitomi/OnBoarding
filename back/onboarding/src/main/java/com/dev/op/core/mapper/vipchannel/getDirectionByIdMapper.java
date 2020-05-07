package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;

public class getDirectionByIdMapper implements RowMapper<getDirectionByIdModel> {
	
	@Override
	public getDirectionByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getDirectionByIdModel getDirectionById = new getDirectionByIdModel();
		getDirectionById.setDirection(rs.getString("direction"));
		getDirectionById.setName(rs.getString("name"));
		getDirectionById.setNumber(rs.getString("number"));
		return getDirectionById;
	}
}
