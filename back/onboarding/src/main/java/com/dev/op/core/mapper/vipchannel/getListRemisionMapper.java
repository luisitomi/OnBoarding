package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListRemisionModel;

public class getListRemisionMapper implements RowMapper<getListRemisionModel> {
	
	@Override
	public getListRemisionModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListRemisionModel getListRemision = new getListRemisionModel();
		getListRemision.setId(rs.getInt("remisionId"));
		getListRemision.setName(rs.getString("nombre"));
		getListRemision.setItem(rs.getInt("items"));
		getListRemision.setAutorizhe(rs.getString("autorizado"));
		getListRemision.setImpor(rs.getString("import"));
		getListRemision.setIgv(rs.getString("igv"));
		getListRemision.setSumation(rs.getString("sumation"));
		return getListRemision;
	}
}
