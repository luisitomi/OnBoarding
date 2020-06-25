package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.dev.op.core.dto.vipchannel.getListTecniModel;
import com.dev.op.core.mapper.vipchannel.getListTecniMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListTecniJdbcRepository")
public class getListTecniCustomJdbcRepository implements getListTecniJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListTecniModel> getListTecni() {
		List<getListTecniModel> getListTecni = new ArrayList<getListTecniModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTTECNI);
			simpleJdbcCall.returningResultSet("getListTecni", new getListTecniMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListTecni = (List<getListTecniModel>) result.get("getListTecni");
			return getListTecni;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
