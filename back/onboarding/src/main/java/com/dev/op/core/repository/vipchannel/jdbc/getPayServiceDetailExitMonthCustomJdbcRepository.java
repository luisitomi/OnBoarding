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

import com.dev.op.core.dto.vipchannel.getPayServiceDetailExitMonthModel;
import com.dev.op.core.mapper.vipchannel.getPayServiceDetailExitMonthMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getPayServiceDetailExitMonthJdbcRepository")
public class getPayServiceDetailExitMonthCustomJdbcRepository implements getPayServiceDetailExitMonthJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getPayServiceDetailExitMonthModel> getPayServiceDetailExitMonth(String document,String code, String user) {
		List<getPayServiceDetailExitMonthModel> getPayServiceDetailExitMonth = new ArrayList<getPayServiceDetailExitMonthModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPAYSERVICEDETAILEXITMONTH);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getPayServiceDetailExitMonth", new getPayServiceDetailExitMonthMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getPayServiceDetailExitMonth = (List<getPayServiceDetailExitMonthModel>) result.get("getPayServiceDetailExitMonth");
			return getPayServiceDetailExitMonth;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
