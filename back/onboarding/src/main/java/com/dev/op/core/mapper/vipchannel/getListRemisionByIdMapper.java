package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;

public class getListRemisionByIdMapper implements RowMapper<getListRemisionByIdModel> {
	
	@Override
	public getListRemisionByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListRemisionByIdModel getListRemisionById = new getListRemisionByIdModel();
		getListRemisionById.setId(rs.getInt("itemId"));
		getListRemisionById.setProduct(rs.getString("product"));
		getListRemisionById.setCode(rs.getString("codigo"));
		getListRemisionById.setDescription(rs.getString("descripcion"));
		getListRemisionById.setCodeProduct(rs.getString("codigoproducto"));
		getListRemisionById.setMeditation(rs.getString("medida"));
		getListRemisionById.setCount(rs.getInt("cantidad"));
		getListRemisionById.setPrice(rs.getString("price"));
		getListRemisionById.setDesc(rs.getString("descu"));
		getListRemisionById.setImpor(rs.getString("import"));
		return getListRemisionById;
	}
}
