package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getManagerSumationModel;

public class getManagerSumationMapper implements RowMapper<getManagerSumationModel> {
	
	@Override
	public getManagerSumationModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getManagerSumationModel getManagerSumation = new getManagerSumationModel();
		getManagerSumation.setManager(rs.getString("manager"));
		getManagerSumation.setAmount(rs.getBigDecimal("amount"));
		return getManagerSumation;
	}
}
