package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;

public class getServicePreInstallMapper implements RowMapper<getServicePreInstallModel> {
	
	@Override
	public getServicePreInstallModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getServicePreInstallModel getServicePreInstall = new getServicePreInstallModel();
		getServicePreInstall.setDetail(rs.getInt("detalleId"));
		getServicePreInstall.setNext(rs.getInt("consecutivo"));
		getServicePreInstall.setClient(rs.getString("client"));
		getServicePreInstall.setDocument(rs.getString("documento"));
		getServicePreInstall.setCode(rs.getString("codigo"));
		getServicePreInstall.setAgreed(rs.getString("fecha_pactada"));
		getServicePreInstall.setDescription(rs.getString("motivo_instalacion"));
		getServicePreInstall.setService(rs.getString("nombre"));
		getServicePreInstall.setInstall(rs.getString("fecha_instalacion_inicial"));
		getServicePreInstall.setStatus(rs.getString("des"));
		getServicePreInstall.setSeller(rs.getString("sale"));
		getServicePreInstall.setActive(rs.getInt("pending"));
		return getServicePreInstall;
	}
}
