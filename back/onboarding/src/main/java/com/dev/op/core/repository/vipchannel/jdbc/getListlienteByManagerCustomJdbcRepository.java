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

import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;
import com.dev.op.core.mapper.vipchannel.getListlienteByManagerMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListlienteByManagerJdbcRepository")
public class getListlienteByManagerCustomJdbcRepository implements getListlienteByManagerJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListlienteByManagerModel> getListlienteByManager(String manager) {
		List<getListlienteByManagerModel> getListlienteByManager = new ArrayList<getListlienteByManagerModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTCLIENTEBYMANAGER);
			simpleJdbcCall.declareParameters(new SqlParameter("manager", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getListlienteByManager", new getListlienteByManagerMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("manager", manager);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListlienteByManager = (List<getListlienteByManagerModel>) result.get("getListlienteByManager");
			return getListlienteByManager;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
