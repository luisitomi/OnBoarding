package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListOnuStateModel;

public class getListOnuStateMapper implements RowMapper<getListOnuStateModel> {
	
	@Override
	public getListOnuStateModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListOnuStateModel getListOnuState = new getListOnuStateModel();
		getListOnuState.setId(rs.getInt("id"));
		getListOnuState.setSerie(rs.getString("serie"));
		getListOnuState.setMac(rs.getString("mac"));
		getListOnuState.setSsid(rs.getString("ssid"));
		getListOnuState.setPass(rs.getString("pass"));
		getListOnuState.setActivo(rs.getInt("activo"));
		return getListOnuState;
	}
}
