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

import com.dev.op.core.dto.vipchannel.getModuleModel;
import com.dev.op.core.mapper.vipchannel.getModuleMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getModuleJdbcRepository")
public class getModuleCustomJdbcRepository implements getModuleJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getModuleModel> getModule() {
		List<getModuleModel> getModule = new ArrayList<getModuleModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETMODULE);
			simpleJdbcCall.returningResultSet("getModule", new getModuleMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getModule = (List<getModuleModel>) result.get("getModule");
			return getModule;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
