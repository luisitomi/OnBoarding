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

import com.dev.op.core.dto.vipchannel.getListDistictModel;
import com.dev.op.core.mapper.vipchannel.getListDistictMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListDistictJdbcRepository")
public class getListDistictCustomJdbcRepository implements getListDistictJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListDistictModel> getListDistict() {
		List<getListDistictModel> getListDistict = new ArrayList<getListDistictModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTDISTICT);
			simpleJdbcCall.returningResultSet("getListDistict", new getListDistictMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListDistict = (List<getListDistictModel>) result.get("getListDistict");
			return getListDistict;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
