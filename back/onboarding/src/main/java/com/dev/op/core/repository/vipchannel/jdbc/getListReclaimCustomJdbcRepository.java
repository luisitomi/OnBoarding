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

import com.dev.op.core.dto.vipchannel.getListReclaimModel;
import com.dev.op.core.mapper.vipchannel.getListReclaimMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListReclaimJdbcRepository")
public class getListReclaimCustomJdbcRepository implements getListReclaimJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListReclaimModel> getListReclaim() {
		List<getListReclaimModel> getListReclaim = new ArrayList<getListReclaimModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTRECLAIM);
			simpleJdbcCall.returningResultSet("getListReclaim", new getListReclaimMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListReclaim = (List<getListReclaimModel>) result.get("getListReclaim");
			return getListReclaim;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
