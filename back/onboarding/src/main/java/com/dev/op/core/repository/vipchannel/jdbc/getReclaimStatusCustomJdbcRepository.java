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

import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;
import com.dev.op.core.mapper.vipchannel.getReclaimStatusMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getReclaimStatusJdbcRepository")
public class getReclaimStatusCustomJdbcRepository implements getReclaimStatusJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getReclaimStatusModel> getReclaimStatus(String datei,String datef) {
		List<getReclaimStatusModel> getReclaimStatus = new ArrayList<getReclaimStatusModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETRECLAIMSTATUS);
			simpleJdbcCall.declareParameters(new SqlParameter("datei", Types.VARCHAR),
					 						 new SqlParameter("datef", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getReclaimStatus", new getReclaimStatusMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("datei", datei);
			inParams.addValue("datef", datef);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getReclaimStatus = (List<getReclaimStatusModel>) result.get("getReclaimStatus");
			return getReclaimStatus;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
