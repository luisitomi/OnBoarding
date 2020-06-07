package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListDistictModel;

public class getListDistictMapper implements RowMapper<getListDistictModel> {
	
	@Override
	public getListDistictModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListDistictModel getListDistict = new getListDistictModel();
		getListDistict.setId(rs.getInt("distritoId"));
		getListDistict.setName(rs.getString("nombre"));
		return getListDistict;
	}
}
