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

import com.dev.op.core.dto.vipchannel.getListStreetModel;
import com.dev.op.core.mapper.vipchannel.getListStreetMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListStreetJdbcRepository")
public class getListStreetCustomJdbcRepository implements getListStreetJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListStreetModel> getListStreet(Integer distric) {
		List<getListStreetModel> getListStreet = new ArrayList<getListStreetModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTSTREET);
			simpleJdbcCall.declareParameters(new SqlParameter("distric", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListStreet", new getListStreetMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("distric", distric);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListStreet = (List<getListStreetModel>) result.get("getListStreet");
			return getListStreet;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}