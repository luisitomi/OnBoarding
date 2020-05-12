package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListMangerModel;

public class getListMangerMapper implements RowMapper<getListMangerModel> {
	
	@Override
	public getListMangerModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListMangerModel getListManger = new getListMangerModel();
		getListManger.setId(rs.getInt("id"));
		getListManger.setManager(rs.getString("manager"));
		return getListManger;
	}
}
