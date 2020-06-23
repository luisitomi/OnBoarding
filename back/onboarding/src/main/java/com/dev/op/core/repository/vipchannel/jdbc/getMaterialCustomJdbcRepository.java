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

import com.dev.op.core.dto.vipchannel.getMaterialModel;
import com.dev.op.core.mapper.vipchannel.getMaterialMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getMaterialJdbcRepository")
public class getMaterialCustomJdbcRepository implements getMaterialJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getMaterialModel> getMaterial() {
		List<getMaterialModel> getMaterial = new ArrayList<getMaterialModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETMATERIAL);
			simpleJdbcCall.returningResultSet("getMaterial", new getMaterialMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getMaterial = (List<getMaterialModel>) result.get("getMaterial");
			return getMaterial;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
