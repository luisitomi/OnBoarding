package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitModel;

public class getPayServiceDetailExitMapper implements RowMapper<getPayServiceDetailExitModel> {
	
	@Override
	public getPayServiceDetailExitModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailExitModel getPayServiceDetailExit = new getPayServiceDetailExitModel();
		getPayServiceDetailExit.setService(rs.getString("service"));
		getPayServiceDetailExit.setAmount(rs.getString("amount"));
		getPayServiceDetailExit.setStatus(rs.getString("status"));
		getPayServiceDetailExit.setCode(rs.getInt("codeservice"));
		return getPayServiceDetailExit;
	}
}
