package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServiceNotActiveModel;

public class getListServiceNotActiveMapper implements RowMapper<getListServiceNotActiveModel> {
	
	@Override
	public getListServiceNotActiveModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServiceNotActiveModel getListServiceNotActive = new getListServiceNotActiveModel();
		getListServiceNotActive.setId(rs.getInt("servicioId"));
		getListServiceNotActive.setName(rs.getString("nombre"));
		return getListServiceNotActive;
	}
}
