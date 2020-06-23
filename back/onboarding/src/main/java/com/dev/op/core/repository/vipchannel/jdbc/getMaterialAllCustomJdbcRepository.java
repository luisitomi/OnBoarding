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

import com.dev.op.core.dto.vipchannel.getMaterialAllModel;
import com.dev.op.core.mapper.vipchannel.getMaterialAllMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getMaterialAllJdbcRepository")
public class getMaterialAllCustomJdbcRepository implements getMaterialAllJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getMaterialAllModel> getMaterialAll() {
		List<getMaterialAllModel> getMaterialAll = new ArrayList<getMaterialAllModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETMATERIALALL);
			simpleJdbcCall.returningResultSet("getMaterialAll", new getMaterialAllMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getMaterialAll = (List<getMaterialAllModel>) result.get("getMaterialAll");
			return getMaterialAll;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
