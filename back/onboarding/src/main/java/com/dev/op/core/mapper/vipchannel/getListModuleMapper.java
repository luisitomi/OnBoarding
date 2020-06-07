package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListModuleModel;

public class getListModuleMapper implements RowMapper<getListModuleModel> {
	
	@Override
	public getListModuleModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListModuleModel getListModule = new getListModuleModel();
		getListModule.setId(rs.getInt("idmodulo"));
		getListModule.setDescription(rs.getString("descripcion"));
		getListModule.setRuta(rs.getString("ruta"));
		getListModule.setIcon(rs.getString("imagen"));
		return getListModule;
	}
}
