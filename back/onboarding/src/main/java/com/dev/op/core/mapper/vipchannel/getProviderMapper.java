package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getProviderModel;

public class getProviderMapper implements RowMapper<getProviderModel> {
	
	@Override
	public getProviderModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getProviderModel getProvider = new getProviderModel();
		getProvider.setId(rs.getInt("proveedorId"));
		getProvider.setName(rs.getString("nombre"));
		return getProvider;
	}
}
