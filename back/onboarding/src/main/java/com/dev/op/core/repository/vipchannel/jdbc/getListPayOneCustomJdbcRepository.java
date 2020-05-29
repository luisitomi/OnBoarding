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

import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.mapper.vipchannel.getListPayOneMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListPayOneJdbcRepository")
public class getListPayOneCustomJdbcRepository implements getListPayOneJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListPayOneModel> getListPayOne() {
		List<getListPayOneModel> getListPayOne = new ArrayList<getListPayOneModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTPAYONE);
			simpleJdbcCall.returningResultSet("getListPayOne", new getListPayOneMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListPayOne = (List<getListPayOneModel>) result.get("getListPayOne");
			return getListPayOne;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
