package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListActivationModel;

public class getListActivationMapper implements RowMapper<getListActivationModel> {
	
	@Override
	public getListActivationModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListActivationModel getListActivation = new getListActivationModel();
		getListActivation.setId(rs.getInt("activacionId"));
		getListActivation.setClient(rs.getString("client"));
		getListActivation.setDirection(rs.getString("direction"));
		getListActivation.setTec(rs.getString("tecn"));
		getListActivation.setSerie(rs.getString("serie"));
		return getListActivation;
	}
}
