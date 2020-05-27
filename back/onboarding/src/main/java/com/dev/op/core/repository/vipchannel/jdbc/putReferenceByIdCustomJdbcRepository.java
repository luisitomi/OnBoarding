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
import com.dev.op.core.mapper.vipchannel.putReferenceByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putReferenceByIdJdbcRepository")
public class putReferenceByIdCustomJdbcRepository implements putReferenceByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putReferenceById(String document,String code,String description) {
		List<ResponseModel> putReferenceById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTREFERENCEBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("description", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("putReferenceById", new putReferenceByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("description", description);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putReferenceById = (List<ResponseModel>) result.get("putReferenceById");
			return putReferenceById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
