package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getMaterialModel;

public class getMaterialMapper implements RowMapper<getMaterialModel> {
	
	@Override
	public getMaterialModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getMaterialModel getMaterial = new getMaterialModel();
		getMaterial.setId(rs.getInt("materialId"));
		getMaterial.setName(rs.getString("nombre"));
		getMaterial.setActive(rs.getInt("activo"));
		return getMaterial;
	}
}
