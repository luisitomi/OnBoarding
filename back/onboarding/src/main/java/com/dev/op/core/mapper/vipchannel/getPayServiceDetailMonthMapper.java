package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteMonthModel;

public class getPayServiceDetailMonthMapper implements RowMapper<getPayServiceDetailDeleteMonthModel> {
	
	@Override
	public getPayServiceDetailDeleteMonthModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailDeleteMonthModel getPayServiceDetailDeleteMonth = new getPayServiceDetailDeleteMonthModel();
		getPayServiceDetailDeleteMonth.setInformation(rs.getString("information"));
		getPayServiceDetailDeleteMonth.setService(rs.getString("service"));
		getPayServiceDetailDeleteMonth.setAmount(rs.getBigDecimal("amount"));
		return getPayServiceDetailDeleteMonth;
	}
}
