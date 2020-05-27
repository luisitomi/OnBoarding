package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.ResponseModel;

public class postPayServiceMapper implements RowMapper<ResponseModel> {
	
	@Override
	public ResponseModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		ResponseModel Response = new ResponseModel();
		Response.setId(rs.getInt("id"));
		return Response;
	}
}
