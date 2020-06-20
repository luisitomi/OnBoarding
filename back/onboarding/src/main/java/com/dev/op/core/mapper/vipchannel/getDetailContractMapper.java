package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getDetailContractModel;

public class getDetailContractMapper implements RowMapper<getDetailContractModel> {
	
	@Override
	public getDetailContractModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getDetailContractModel getDetailContract = new getDetailContractModel();
		getDetailContract.setName(rs.getString("message"));
		getDetailContract.setEmail(rs.getString("email"));
		return getDetailContract;
	}
}
