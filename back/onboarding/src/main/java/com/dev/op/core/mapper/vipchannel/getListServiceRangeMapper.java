package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListServiceRangeModel;

public class getListServiceRangeMapper implements RowMapper<getListServiceRangeModel> {
	
	@Override
	public getListServiceRangeModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListServiceRangeModel getListServiceRange = new getListServiceRangeModel();
		getListServiceRange.setService(rs.getString("service"));
		getListServiceRange.setDocument(rs.getString("document"));
		getListServiceRange.setCode(rs.getString("code"));
		getListServiceRange.setClient(rs.getString("client"));
		getListServiceRange.setDirection(rs.getString("direction"));
		getListServiceRange.setTecn(rs.getString("tecn"));
		getListServiceRange.setFech(rs.getString("fech"));
		return getListServiceRange;
	}
}
