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

import com.dev.op.core.dto.vipchannel.getManagaerCountModel;
import com.dev.op.core.mapper.vipchannel.getManagaerCountMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getManagaerCountJdbcRepository")
public class getManagaerCountCustomJdbcRepository implements getManagaerCountJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getManagaerCountModel> getManagaerCount(String con) {
		List<getManagaerCountModel> getManagaerCount = new ArrayList<getManagaerCountModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETMANAGERCOUNT);
			simpleJdbcCall.declareParameters(new SqlParameter("con", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getManagaerCount", new getManagaerCountMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("con", con);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getManagaerCount = (List<getManagaerCountModel>) result.get("getManagaerCount");
			return getManagaerCount;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
