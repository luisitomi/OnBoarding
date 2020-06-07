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

import com.dev.op.core.dto.vipchannel.getUserDataModel;
import com.dev.op.core.mapper.vipchannel.getUserDataMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getUserDataJdbcRepository")
public class getUserDataCustomJdbcRepository implements getUserDataJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getUserDataModel> getUserData(String user,String pass) {
		List<getUserDataModel> getUserData = new ArrayList<getUserDataModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETUSERDATA);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR),
											 new SqlParameter("pass", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getUserData", new getUserDataMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			inParams.addValue("pass", pass);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getUserData = (List<getUserDataModel>) result.get("getUserData");
			return getUserData;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
