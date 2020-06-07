package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListSubModuleModel;

public class getListSubModuleMapper implements RowMapper<getListSubModuleModel> {
	
	@Override
	public getListSubModuleModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListSubModuleModel getListSubModule = new getListSubModuleModel();
		getListSubModule.setId(rs.getInt("idmodulo"));
		getListSubModule.setDecription(rs.getString("descripcion"));
		getListSubModule.setRuta(rs.getString("ruta"));
		getListSubModule.setIcon(rs.getString("imagen"));
		return getListSubModule;
	}
}
