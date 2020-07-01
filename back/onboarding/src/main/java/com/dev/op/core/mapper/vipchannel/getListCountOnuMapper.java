package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListCountOnuModel;

public class getListCountOnuMapper implements RowMapper<getListCountOnuModel> {
	
	@Override
	public getListCountOnuModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListCountOnuModel getListCountOnu = new getListCountOnuModel();
		getListCountOnu.setId(rs.getInt("id"));
		return getListCountOnu;
	}
}
