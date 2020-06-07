package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListSellerModel;

public class getListSellerMapper implements RowMapper<getListSellerModel> {
	
	@Override
	public getListSellerModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListSellerModel getListSeller = new getListSellerModel();
		getListSeller.setId(rs.getInt("vendedorId"));
		getListSeller.setName(rs.getString("client"));
		return getListSeller;
	}
}
