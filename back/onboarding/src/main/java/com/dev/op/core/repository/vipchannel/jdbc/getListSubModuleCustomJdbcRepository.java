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

import com.dev.op.core.dto.vipchannel.getListSubModuleModel;
import com.dev.op.core.mapper.vipchannel.getListSubModuleMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListSubModuleJdbcRepository")
public class getListSubModuleCustomJdbcRepository implements getListSubModuleJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListSubModuleModel> getListSubModule(String user) {
		List<getListSubModuleModel> getListSubModule = new ArrayList<getListSubModuleModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTSUBMODULE);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getListSubModule", new getListSubModuleMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListSubModule = (List<getListSubModuleModel>) result.get("getListSubModule");
			return getListSubModule;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
