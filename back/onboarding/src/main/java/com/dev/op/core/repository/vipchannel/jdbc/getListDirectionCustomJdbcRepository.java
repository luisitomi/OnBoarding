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

import com.dev.op.core.dto.vipchannel.getListDirectionModel;
import com.dev.op.core.mapper.vipchannel.getListDirectionMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListDirectionJdbcRepository")
public class getListDirectionCustomJdbcRepository implements getListDirectionJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListDirectionModel> getListDirection() {
		List<getListDirectionModel> getListDirection = new ArrayList<getListDirectionModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTDIRECTION);
			simpleJdbcCall.returningResultSet("getListDirection", new getListDirectionMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListDirection = (List<getListDirectionModel>) result.get("getListDirection");
			return getListDirection;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
