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

import com.dev.op.core.dto.vipchannel.getListRemisionModel;
import com.dev.op.core.mapper.vipchannel.getListRemisionMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListRemisionJdbcRepository")
public class getListRemisionCustomJdbcRepository implements getListRemisionJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListRemisionModel> getListRemision() {
		List<getListRemisionModel> getListRemision = new ArrayList<getListRemisionModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTREMISION);
			simpleJdbcCall.returningResultSet("getListRemision", new getListRemisionMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListRemision = (List<getListRemisionModel>) result.get("getListRemision");
			return getListRemision;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
