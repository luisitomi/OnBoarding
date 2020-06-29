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

import com.dev.op.core.dto.vipchannel.getListRemisionByIdModel;
import com.dev.op.core.mapper.vipchannel.getListRemisionByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListRemisionByIdJdbcRepository")
public class getListRemisionByIdCustomJdbcRepository implements getListRemisionByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListRemisionByIdModel> getListRemisionById(Integer remisId) {
		List<getListRemisionByIdModel> getListRemisionById = new ArrayList<getListRemisionByIdModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTREMISIONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("remisId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListRemisionById", new getListRemisionByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("remisId", remisId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListRemisionById = (List<getListRemisionByIdModel>) result.get("getListRemisionById");
			return getListRemisionById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
