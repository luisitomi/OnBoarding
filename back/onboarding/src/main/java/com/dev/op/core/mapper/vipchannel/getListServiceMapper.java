package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServiceModel;

public class getListServiceMapper implements RowMapper<getListServiceModel> {
	
	@Override
	public getListServiceModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServiceModel getListService = new getListServiceModel();
		getListService.setId(rs.getInt("servicioId"));
		getListService.setDescription(rs.getString("nombre"));
		return getListService;
	}
}
