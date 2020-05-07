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

import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.mapper.vipchannel.getPersonByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getPersonByIdJdbcRepository")
public class getPersonByIdCustomJdbcRepository implements getPersonByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getPersonByIdModel> getPersonById(String document) {
		List<getPersonByIdModel> getPersonById = new ArrayList<getPersonByIdModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPERSONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getPersonById", new getPersonByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getPersonById = (List<getPersonByIdModel>) result.get("getPersonById");
			return getPersonById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
