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

import com.dev.op.core.dto.vipchannel.getListPayModel;
import com.dev.op.core.mapper.vipchannel.getListPayMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListPayJdbcRepository")
public class getListPayCustomJdbcRepository implements getListPayJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListPayModel> getListPay(String user,String explicite) {
		List<getListPayModel> getListPay = new ArrayList<getListPayModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTPAY);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR),
											 new SqlParameter("explicite", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getListPay", new getListPayMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			inParams.addValue("explicite", explicite);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListPay = (List<getListPayModel>) result.get("getListPay");
			return getListPay;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
