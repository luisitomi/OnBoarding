package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getModuleModel;

public class getModuleMapper implements RowMapper<getModuleModel> {
	
	@Override
	public getModuleModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getModuleModel getModule = new getModuleModel();
		getModule.setId(rs.getInt("idmodulo"));
		getModule.setDescription(rs.getString("descripcion"));
		return getModule;
	}
}
