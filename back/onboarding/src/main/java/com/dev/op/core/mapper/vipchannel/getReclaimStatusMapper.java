package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;

public class getReclaimStatusMapper implements RowMapper<getReclaimStatusModel> {
	
	@Override
	public getReclaimStatusModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getReclaimStatusModel getReclaimStatus = new getReclaimStatusModel();
		getReclaimStatus.setId(rs.getInt("id"));
		getReclaimStatus.setCode(rs.getString("codigo"));
		getReclaimStatus.setClient(rs.getString("client"));
		getReclaimStatus.setService(rs.getString("service"));
		getReclaimStatus.setDirection(rs.getString("nombre") + " " + rs.getString("numero"));
		getReclaimStatus.setDescripcion(rs.getString("descripcion"));
		getReclaimStatus.setStatus(rs.getInt("activo"));
		return getReclaimStatus;
	}
}
