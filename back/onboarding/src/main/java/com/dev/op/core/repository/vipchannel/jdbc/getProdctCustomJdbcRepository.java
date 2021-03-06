package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.dev.op.core.dto.vipchannel.getProdctModel;
import com.dev.op.core.mapper.vipchannel.getProdctMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getProdctJdbcRepository")
public class getProdctCustomJdbcRepository implements getProdctJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getProdctModel> getProdct() {
		List<getProdctModel> getProdct = new ArrayList<getProdctModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPRODUCT);
			simpleJdbcCall.returningResultSet("getProdct", new getProdctMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getProdct = (List<getProdctModel>) result.get("getProdct");
			return getProdct;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
