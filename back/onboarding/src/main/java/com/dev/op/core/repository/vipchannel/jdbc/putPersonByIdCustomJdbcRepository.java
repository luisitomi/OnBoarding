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

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.mapper.vipchannel.putPersonByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putPersonByIdJdbcRepository")
public class putPersonByIdCustomJdbcRepository implements putPersonByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putPersonById(String document,String name,String last,String second,String client) {
		List<ResponseModel> putPersonById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTPERSONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("last", Types.VARCHAR),
											 new SqlParameter("second", Types.VARCHAR),
											 new SqlParameter("client", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("putPersonById", new putPersonByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("name", name);
			inParams.addValue("last", last);
			inParams.addValue("second", second);
			inParams.addValue("client", client);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putPersonById = (List<ResponseModel>) result.get("putPersonById");
			return putPersonById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
