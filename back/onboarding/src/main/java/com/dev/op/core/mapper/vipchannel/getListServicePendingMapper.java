package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServicePendingModel;

public class getListServicePendingMapper implements RowMapper<getListServicePendingModel> {
	
	@Override
	public getListServicePendingModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServicePendingModel getListServicePending = new getListServicePendingModel();
		getListServicePending.setDetalleId(rs.getInt("detalleId"));
		getListServicePending.setNextId(rs.getInt("consecutivo"));
		getListServicePending.setClient(rs.getString("nombre"));
		getListServicePending.setName(rs.getString("client"));
		getListServicePending.setSale(rs.getString("sale"));
		getListServicePending.setDocument(rs.getString("documento"));
		getListServicePending.setCode(rs.getString("codigo"));
		getListServicePending.setDateP(rs.getString("fecha_pactada"));
		getListServicePending.setAsunt(rs.getString("motivo_instalacion"));
		return getListServicePending;
	}
}
