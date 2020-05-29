package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListPayOneModel;

public class getListPayOneMapper implements RowMapper<getListPayOneModel> {
	
	@Override
	public getListPayOneModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListPayOneModel getListPayOne = new getListPayOneModel();
		getListPayOne.setId(rs.getString("id"));
		getListPayOne.setCode(rs.getString("code"));
		getListPayOne.setClient(rs.getString("client"));
		getListPayOne.setAmountOne(rs.getString("amount"));
		getListPayOne.setAmountTwo(rs.getString("amounttwo"));
		getListPayOne.setAmountThree(rs.getString("amountthree"));
		getListPayOne.setSumation(rs.getString("sumation"));
		return getListPayOne;
	}
}
