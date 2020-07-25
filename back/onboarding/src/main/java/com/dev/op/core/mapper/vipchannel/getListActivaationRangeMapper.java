package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListActivaationRangeModel;

public class getListActivaationRangeMapper implements RowMapper<getListActivaationRangeModel> {
	
	@Override
	public getListActivaationRangeModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListActivaationRangeModel getListActivaationRange = new getListActivaationRangeModel();
		getListActivaationRange.setDocument(rs.getString("document"));
		getListActivaationRange.setCode(rs.getString("code"));
		getListActivaationRange.setClient(rs.getString("client"));
		getListActivaationRange.setDirection(rs.getString("direction"));
		getListActivaationRange.setFech(rs.getString("fech"));
		return getListActivaationRange;
	}
}
