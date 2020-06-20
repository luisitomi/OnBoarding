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
import com.dev.op.core.mapper.vipchannel.postPayServiceExitMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postPayServiceExitJdbcRepository")
public class postPayServiceExitCustomJdbcRepository implements postPayServiceExitJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postPayServiceExit(String document,String code,BigDecimal amount,Integer user, Integer managerId,Integer type, Integer serviceSelect) {
		List<ResponseModel> postPayServiceExit = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTPAYSERVICEEXIT);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("amount", Types.DECIMAL),
											 new SqlParameter("user", Types.INTEGER),
											 new SqlParameter("managerId", Types.INTEGER),
											 new SqlParameter("type", Types.INTEGER),
											 new SqlParameter("serviceSelect", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postPayServiceExit", new postPayServiceExitMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("amount", amount);
			inParams.addValue("user", user);
			inParams.addValue("managerId", managerId);
			inParams.addValue("type", type);
			inParams.addValue("serviceSelect", serviceSelect);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postPayServiceExit = (List<ResponseModel>) result.get("postPayServiceExit");
			return postPayServiceExit;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
