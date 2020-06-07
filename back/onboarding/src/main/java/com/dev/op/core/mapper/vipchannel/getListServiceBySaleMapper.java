package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServiceBySaleModel;

public class getListServiceBySaleMapper implements RowMapper<getListServiceBySaleModel> {
	
	@Override
	public getListServiceBySaleModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServiceBySaleModel getListServiceBySale = new getListServiceBySaleModel();
		getListServiceBySale.setClient(rs.getString("cliente"));
		getListServiceBySale.setDocument(rs.getString("documento"));
		getListServiceBySale.setCode(rs.getString("codigo"));
		getListServiceBySale.setAgreed(rs.getString("fechainicip"));
		getListServiceBySale.setDescription(rs.getString("motivo"));
		getListServiceBySale.setService(rs.getString("servicio"));
		getListServiceBySale.setInstall(rs.getString("fechafinal"));
		getListServiceBySale.setStatus(rs.getString("activo"));
		getListServiceBySale.setSeller(rs.getString("vendedor"));
		return getListServiceBySale;
	}
}
