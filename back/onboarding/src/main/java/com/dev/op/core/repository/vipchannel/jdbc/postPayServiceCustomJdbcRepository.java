package com.dev.op.core.repository.vipchannel.jdbc;

import java.math.BigDecimal;
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
import com.dev.op.core.mapper.vipchannel.postPayServiceMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postPayServiceJdbcRepository")
public class postPayServiceCustomJdbcRepository implements postPayServiceJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postPayService(String document,String code,BigDecimal amount,Integer user, Integer manager) {
		List<ResponseModel> postPayService = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTPAYSERVICE);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("amount", Types.DECIMAL),
											 new SqlParameter("user", Types.INTEGER),
											 new SqlParameter("managerId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postPayService", new postPayServiceMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("amount", amount);
			inParams.addValue("user", user);
			inParams.addValue("managerId", manager);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postPayService = (List<ResponseModel>) result.get("postPayService");
			return postPayService;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
