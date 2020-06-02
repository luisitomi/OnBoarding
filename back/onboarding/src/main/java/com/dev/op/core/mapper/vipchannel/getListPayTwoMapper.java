package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListPayTwoModel;

public class getListPayTwoMapper implements RowMapper<getListPayTwoModel> {
	
	@Override
	public getListPayTwoModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListPayTwoModel getListPayTwo = new getListPayTwoModel();
		getListPayTwo.setId(rs.getString("id"));
		getListPayTwo.setCode(rs.getString("code"));
		getListPayTwo.setClient(rs.getString("client"));
		getListPayTwo.setAmountOne(rs.getString("amount"));
		getListPayTwo.setAmountTwo(rs.getString("amounttwo"));
		getListPayTwo.setAmountThree(rs.getString("amountthree"));
		getListPayTwo.setSumation(rs.getString("sumation"));
		return getListPayTwo;
	}
}
