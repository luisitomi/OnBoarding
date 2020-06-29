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

import com.dev.op.core.dto.vipchannel.getProductProviderModel;
import com.dev.op.core.mapper.vipchannel.getProductProviderMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getProductProviderJdbcRepository")
public class getProductProviderCustomJdbcRepository implements getProductProviderJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getProductProviderModel> getProductProvider() {
		List<getProductProviderModel> getProductProvider = new ArrayList<getProductProviderModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPRODUCTPROVIDER);
			simpleJdbcCall.returningResultSet("getProductProvider", new getProductProviderMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getProductProvider = (List<getProductProviderModel>) result.get("getProductProvider");
			return getProductProvider;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
