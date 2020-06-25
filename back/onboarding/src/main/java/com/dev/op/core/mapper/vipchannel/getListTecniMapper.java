package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListTecniModel;

public class getListTecniMapper implements RowMapper<getListTecniModel> {
	
	@Override
	public getListTecniModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListTecniModel getListTecni = new getListTecniModel();
		getListTecni.setId(rs.getInt("tecnicoId"));
		getListTecni.setName(rs.getString("tec"));
		return getListTecni;
	}
}
