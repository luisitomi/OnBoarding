package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListReclaimModel;

public class getListReclaimMapper implements RowMapper<getListReclaimModel> {
	
	@Override
	public getListReclaimModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListReclaimModel getListReclaim = new getListReclaimModel();
		getListReclaim.setId(rs.getInt("reclamoId"));
		getListReclaim.setName(rs.getString("descripcion"));
		return getListReclaim;
	}
}
