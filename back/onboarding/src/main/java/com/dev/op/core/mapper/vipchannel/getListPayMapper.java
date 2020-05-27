package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListPayModel;

public class getListPayMapper implements RowMapper<getListPayModel> {
	
	@Override
	public getListPayModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListPayModel getListPay = new getListPayModel();
		getListPay.setId(rs.getString("id"));
		getListPay.setCode(rs.getString("code"));
		getListPay.setClient(rs.getString("client"));
		getListPay.setAmountOne(rs.getBigDecimal("amount_month"));
		getListPay.setAmountTwo(rs.getBigDecimal("amount_two"));
		getListPay.setAmountThree(rs.getBigDecimal("amount_three"));
		getListPay.setSumation(rs.getBigDecimal("summation"));
		return getListPay;
	}
}
