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

import com.dev.op.core.dto.vipchannel.getListOnuStateModel;
import com.dev.op.core.mapper.vipchannel.getListOnuStateMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListOnuStateJdbcRepository")
public class getListOnuStateCustomJdbcRepository implements getListOnuStateJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListOnuStateModel> getListOnuState() {
		List<getListOnuStateModel> getListOnuState = new ArrayList<getListOnuStateModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTONUSTATE);
			simpleJdbcCall.returningResultSet("getListOnuState", new getListOnuStateMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListOnuState = (List<getListOnuStateModel>) result.get("getListOnuState");
			return getListOnuState;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
