package com.dev.op.core.repository.vipchannel.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.dev.op.core.dto.vipchannel.getListModuleModel;
import com.dev.op.core.mapper.vipchannel.getListModuleMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListModuleJdbcRepository")
public class getListModuleCustomJdbcRepository implements getListModuleJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListModuleModel> getListModule(String user) {
		List<getListModuleModel> getListModule = new ArrayList<getListModuleModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTMODULE);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getListModule", new getListModuleMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListModule = (List<getListModuleModel>) result.get("getListModule");
			return getListModule;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
