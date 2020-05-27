package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;

public class getListlienteByManagerMapper implements RowMapper<getListlienteByManagerModel> {
	
	@Override
	public getListlienteByManagerModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListlienteByManagerModel getListlienteByManager = new getListlienteByManagerModel();
		getListlienteByManager.setCode(rs.getString("code"));
		getListlienteByManager.setClient(rs.getString("client"));
		getListlienteByManager.setName(rs.getString("name"));
		getListlienteByManager.setNumber(rs.getString("number"));
		getListlienteByManager.setMin(rs.getString("min"));
		getListlienteByManager.setMax(rs.getString("max"));
		getListlienteByManager.setService(rs.getString("name"));
		getListlienteByManager.setAmount(rs.getBigDecimal("amount"));
		return getListlienteByManager;
	}
}
