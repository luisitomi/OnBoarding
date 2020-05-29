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

import com.dev.op.core.dto.vipchannel.getManagerSumationModel;
import com.dev.op.core.mapper.vipchannel.getManagerSumationMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getManagerSumationJdbcRepository")
public class getManagerSumationCustomJdbcRepository implements getManagerSumationJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getManagerSumationModel> getManagerSumation() {
		List<getManagerSumationModel> getManagerSumation = new ArrayList<getManagerSumationModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETMANAGERSUMATION);
			simpleJdbcCall.returningResultSet("getManagerSumation", new getManagerSumationMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getManagerSumation = (List<getManagerSumationModel>) result.get("getManagerSumation");
			return getManagerSumation;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
