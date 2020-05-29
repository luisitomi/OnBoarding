package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;

public class getPayServiceDetailDeleteMonthMapper implements RowMapper<getPayServiceDetailMonthModel> {
	
	@Override
	public getPayServiceDetailMonthModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailMonthModel getPayServiceDetailMonth = new getPayServiceDetailMonthModel();
		getPayServiceDetailMonth.setInformation(rs.getString("information"));
		getPayServiceDetailMonth.setService(rs.getString("service"));
		getPayServiceDetailMonth.setAmount(rs.getBigDecimal("amount"));
		return getPayServiceDetailMonth;
	}
}
