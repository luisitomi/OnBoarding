package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getManagaerCountModel;

public class getManagaerCountMapper implements RowMapper<getManagaerCountModel> {
	
	@Override
	public getManagaerCountModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getManagaerCountModel getManagaerCount = new getManagaerCountModel();
		getManagaerCount.setManager(rs.getString("nombre"));
		getManagaerCount.setAmount(rs.getBigDecimal("monto"));
		return getManagaerCount;
	}
}
