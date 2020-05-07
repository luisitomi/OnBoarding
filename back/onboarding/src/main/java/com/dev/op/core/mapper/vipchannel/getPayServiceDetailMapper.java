package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;

public class getPayServiceDetailMapper implements RowMapper<getPayServiceDetailModel> {
	
	@Override
	public getPayServiceDetailModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPayServiceDetailModel getPayServiceDetail = new getPayServiceDetailModel();
		getPayServiceDetail.setId(rs.getInt("id"));
		getPayServiceDetail.setService(rs.getString("service"));
		getPayServiceDetail.setAmount(rs.getString("amount"));
		return getPayServiceDetail;
	}
}
