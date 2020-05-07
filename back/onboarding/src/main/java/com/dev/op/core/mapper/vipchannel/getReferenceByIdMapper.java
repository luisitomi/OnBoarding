package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;

public class getReferenceByIdMapper implements RowMapper<getReferenceByIdModel> {
	
	@Override
	public getReferenceByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getReferenceByIdModel getReferenceById = new getReferenceByIdModel();
		getReferenceById.setReference(rs.getString("reference"));
		return getReferenceById;
	}
}
