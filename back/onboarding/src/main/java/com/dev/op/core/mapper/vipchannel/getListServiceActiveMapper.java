package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServiceActiveModel;

public class getListServiceActiveMapper implements RowMapper<getListServiceActiveModel> {
	
	@Override
	public getListServiceActiveModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServiceActiveModel getListServiceActive = new getListServiceActiveModel();
		getListServiceActive.setId(rs.getInt("servicioId"));
		getListServiceActive.setName(rs.getString("nombre"));
		return getListServiceActive;
	}
}
