package com.dev.op.core.repository.vipchannel.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
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
import com.dev.op.core.mapper.vipchannel.postChangeAmountMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postChangeAmountJdbcRepository")
public class postChangeAmountCustomJdbcRepository implements postChangeAmountJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postChangeAmount(String document,String code,Integer service,BigDecimal amount,Date dateformat,Integer user) {
		List<ResponseModel> postChangeAmount = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTCHANGEAMOUNT);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("service", Types.INTEGER),
											 new SqlParameter("amount", Types.DECIMAL),
											 new SqlParameter("dateformat", Types.DATE),
											 new SqlParameter("user", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postChangeAmount", new postChangeAmountMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("service", service);
			inParams.addValue("amount", amount);
			inParams.addValue("dateformat", dateformat);
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postChangeAmount = (List<ResponseModel>) result.get("postChangeAmount");
			return postChangeAmount;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
