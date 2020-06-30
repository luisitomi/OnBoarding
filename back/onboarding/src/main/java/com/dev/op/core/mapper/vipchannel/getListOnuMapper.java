package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListOnuModel;

public class getListOnuMapper implements RowMapper<getListOnuModel> {
	
	@Override
	public getListOnuModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListOnuModel getListOnu = new getListOnuModel();
		getListOnu.setId(rs.getInt("onuId"));
		getListOnu.setName(rs.getString("serie"));;
		return getListOnu;
	}
}
