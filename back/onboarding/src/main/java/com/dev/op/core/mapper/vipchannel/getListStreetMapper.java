package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListStreetModel;

public class getListStreetMapper implements RowMapper<getListStreetModel> {
	
	@Override
	public getListStreetModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListStreetModel getListStreet = new getListStreetModel();
		getListStreet.setId(rs.getInt("calleId"));
		getListStreet.setName(rs.getString("nombre"));
		return getListStreet;
	}
}
