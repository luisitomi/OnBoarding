package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListReclaimServiceModel;

public class getListReclaimServiceMapper implements RowMapper<getListReclaimServiceModel> {
	
	@Override
	public getListReclaimServiceModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListReclaimServiceModel getListReclaimService = new getListReclaimServiceModel();
		getListReclaimService.setReclamoD(rs.getInt("reclamoD"));
		getListReclaimService.setClient(rs.getString("client"));
		getListReclaimService.setStreet(rs.getString("street"));
		getListReclaimService.setFecha(rs.getString("fecha"));
		getListReclaimService.setDescripcion(rs.getString("descripcion"));
		getListReclaimService.setTecn(rs.getString("tecn"));
		return getListReclaimService;
	}
}
