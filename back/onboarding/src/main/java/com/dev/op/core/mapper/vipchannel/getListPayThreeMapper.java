package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListPayThreeModel;

public class getListPayThreeMapper implements RowMapper<getListPayThreeModel> {
	
	@Override
	public getListPayThreeModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListPayThreeModel getListPayThree = new getListPayThreeModel();
		getListPayThree.setId(rs.getString("id"));
		getListPayThree.setCode(rs.getString("code"));
		getListPayThree.setClient(rs.getString("client"));
		getListPayThree.setAmountOne(rs.getString("amount"));
		getListPayThree.setAmountTwo(rs.getString("amounttwo"));
		getListPayThree.setAmountThree(rs.getString("amountthree"));
		getListPayThree.setSumation(rs.getString("sumation"));
		return getListPayThree;
	}
}
