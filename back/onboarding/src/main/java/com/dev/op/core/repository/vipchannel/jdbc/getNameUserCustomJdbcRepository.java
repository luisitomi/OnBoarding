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

import com.dev.op.core.dto.vipchannel.getNameUserModel;
import com.dev.op.core.mapper.vipchannel.getNameUserMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getNameUserJdbcRepository")
public class getNameUserCustomJdbcRepository implements getNameUserJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getNameUserModel> getNameUser(String user) {
		List<getNameUserModel> getNameUser = new ArrayList<getNameUserModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETNAMEUSER);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getNameUser", new getNameUserMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getNameUser = (List<getNameUserModel>) result.get("getNameUser");
			return getNameUser;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
