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

import com.dev.op.core.dto.vipchannel.getListMangerModel;
import com.dev.op.core.mapper.vipchannel.getListMangerMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListMangerJdbcRepository")
public class getListMangerCustomJdbcRepository implements getListMangerJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListMangerModel> getListManger() {
		List<getListMangerModel> getListManger = new ArrayList<getListMangerModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTMANAGER);
			simpleJdbcCall.returningResultSet("getListManger", new getListMangerMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListManger = (List<getListMangerModel>) result.get("getListManger");
			return getListManger;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
