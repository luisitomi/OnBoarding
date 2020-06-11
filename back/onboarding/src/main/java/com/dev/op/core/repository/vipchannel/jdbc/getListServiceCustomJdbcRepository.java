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

import com.dev.op.core.dto.vipchannel.getListServiceModel;
import com.dev.op.core.mapper.vipchannel.getListServiceMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListServiceJdbcRepository")
public class getListServiceCustomJdbcRepository implements getListServiceJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListServiceModel> getListService() {
		List<getListServiceModel> getListService = new ArrayList<getListServiceModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTSERVICE);
			simpleJdbcCall.returningResultSet("getListService", new getListServiceMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListService = (List<getListServiceModel>) result.get("getListService");
			return getListService;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
