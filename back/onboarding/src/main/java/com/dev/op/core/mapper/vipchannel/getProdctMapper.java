package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getProdctModel;

public class getProdctMapper implements RowMapper<getProdctModel> {
	
	@Override
	public getProdctModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getProdctModel getProdct = new getProdctModel();
		getProdct.setId(rs.getInt("productoId"));
		getProdct.setName(rs.getString("nombre"));
		getProdct.setCode(rs.getString("codigo"));
		getProdct.setDescription(rs.getString("descripcion"));
		getProdct.setCodeProduct(rs.getString("codigoproducto"));
		getProdct.setMeditation(rs.getString("medida"));
		return getProdct;
	}
}
