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

import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;
import com.dev.op.core.mapper.vipchannel.getPayServiceDetailMonthMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getPayServiceDetailMonthJdbcRepository")
public class getPayServiceDetailMonthCustomJdbcRepository implements getPayServiceDetailMonthJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getPayServiceDetailMonthModel> getPayServiceDetailMonth(String document,String code, String user) {
		List<getPayServiceDetailMonthModel> getPayServiceDetailMonth = new ArrayList<getPayServiceDetailMonthModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPAYSERVICEDETAILMONTH);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getPayServiceDetailMonth", new getPayServiceDetailMonthMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getPayServiceDetailMonth = (List<getPayServiceDetailMonthModel>) result.get("getPayServiceDetailMonth");
			return getPayServiceDetailMonth;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
