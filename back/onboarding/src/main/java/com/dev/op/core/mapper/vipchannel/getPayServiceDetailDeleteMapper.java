package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailDeleteModel;

public class getPayServiceDetailDeleteMapper implements RowMapper<getPayServiceDetailDeleteModel> {
	
	@Override
	public getPayServiceDetailDeleteModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailDeleteModel getPayServiceDetailDelete = new getPayServiceDetailDeleteModel();
		getPayServiceDetailDelete.setService(rs.getString("service"));
		getPayServiceDetailDelete.setAmount(rs.getString("amount"));
		getPayServiceDetailDelete.setStatus(rs.getString("status"));
		return getPayServiceDetailDelete;
	}
}
