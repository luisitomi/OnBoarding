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

import com.dev.op.core.dto.vipchannel.getListUserModel;
import com.dev.op.core.mapper.vipchannel.getListUserMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListUserJdbcRepository")
public class getListUserCustomJdbcRepository implements getListUserJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListUserModel> getListUser(Integer codeUser) {
		List<getListUserModel> getListUser = new ArrayList<getListUserModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTUSER);
			simpleJdbcCall.declareParameters(new SqlParameter("codeUser", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListUser", new getListUserMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("codeUser", codeUser);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListUser = (List<getListUserModel>) result.get("getListUser");
			return getListUser;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
