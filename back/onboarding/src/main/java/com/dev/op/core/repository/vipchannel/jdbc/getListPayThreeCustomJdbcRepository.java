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

import com.dev.op.core.dto.vipchannel.getListPayThreeModel;
import com.dev.op.core.mapper.vipchannel.getListPayThreeMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListPayThreeJdbcRepository")
public class getListPayThreeCustomJdbcRepository implements getListPayThreeJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListPayThreeModel> getListPayThree() {
		List<getListPayThreeModel> getListPayThree = new ArrayList<getListPayThreeModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTPAYTHREE);
			simpleJdbcCall.returningResultSet("getListPayThree", new getListPayThreeMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListPayThree = (List<getListPayThreeModel>) result.get("getListPayThree");
			return getListPayThree;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
