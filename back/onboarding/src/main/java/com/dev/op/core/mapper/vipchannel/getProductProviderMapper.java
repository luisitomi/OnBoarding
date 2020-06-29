package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getProductProviderModel;

public class getProductProviderMapper implements RowMapper<getProductProviderModel> {
	
	@Override
	public getProductProviderModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getProductProviderModel getProductProvider = new getProductProviderModel();
		getProductProvider.setId(rs.getString("product"));
		getProductProvider.setName(rs.getString("nombre"));
		return getProductProvider;
	}
}
