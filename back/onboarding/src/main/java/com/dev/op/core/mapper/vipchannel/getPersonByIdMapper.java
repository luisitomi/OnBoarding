package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPersonByIdModel;

public class getPersonByIdMapper implements RowMapper<getPersonByIdModel> {
	
	@Override
	public getPersonByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPersonByIdModel getPersonById = new getPersonByIdModel();
		getPersonById.setClient(rs.getString("client"));
		getPersonById.setType(rs.getString("type"));
		getPersonById.setName(rs.getString("name"));
		getPersonById.setLast(rs.getString("last"));
		getPersonById.setSecond(rs.getString("second"));
		getPersonById.setCustomer(rs.getString("customer"));
		return getPersonById;
	}
}
