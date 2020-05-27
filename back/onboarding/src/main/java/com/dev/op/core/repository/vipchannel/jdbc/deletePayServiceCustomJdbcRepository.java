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
import com.dev.op.core.mapper.vipchannel.deletePayServiceMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("deletePayServiceJdbcRepository")
public class deletePayServiceCustomJdbcRepository implements deletePayServiceJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> deletePayService(String code) {
		List<ResponseModel> deletePayService = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.DELETEPAYSERVICE);
			simpleJdbcCall.declareParameters(new SqlParameter("code", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("deletePayService", new deletePayServiceMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("code", code);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			deletePayService = (List<ResponseModel>) result.get("deletePayService");
			return deletePayService;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
