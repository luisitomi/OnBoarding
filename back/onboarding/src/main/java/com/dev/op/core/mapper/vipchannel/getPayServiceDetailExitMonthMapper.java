package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitMonthModel;

public class getPayServiceDetailExitMonthMapper implements RowMapper<getPayServiceDetailExitMonthModel> {
	
	@Override
	public getPayServiceDetailExitMonthModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailExitMonthModel getPayServiceDetailExitMonth = new getPayServiceDetailExitMonthModel();
		getPayServiceDetailExitMonth.setInformation(rs.getString("information"));
		getPayServiceDetailExitMonth.setService(rs.getString("service"));
		getPayServiceDetailExitMonth.setAmount(rs.getBigDecimal("amount"));
		return getPayServiceDetailExitMonth;
	}
}
