package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getMaterialAllModel;

public class getMaterialAllMapper implements RowMapper<getMaterialAllModel> {
	
	@Override
	public getMaterialAllModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getMaterialAllModel getMaterialAll = new getMaterialAllModel();
		getMaterialAll.setId(rs.getInt("materialId"));
		getMaterialAll.setName(rs.getString("nombre"));
		getMaterialAll.setActive(rs.getInt("activo"));
		return getMaterialAll;
	}
}
