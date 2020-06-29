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

import com.dev.op.core.dto.vipchannel.getProviderModel;
import com.dev.op.core.mapper.vipchannel.getProviderMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getProviderJdbcRepository")
public class getProviderCustomJdbcRepository implements getProviderJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getProviderModel> getProvider() {
		List<getProviderModel> getProvider = new ArrayList<getProviderModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPROVIDER);
			simpleJdbcCall.returningResultSet("getProvider", new getProviderMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getProvider = (List<getProviderModel>) result.get("getProvider");
			return getProvider;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
