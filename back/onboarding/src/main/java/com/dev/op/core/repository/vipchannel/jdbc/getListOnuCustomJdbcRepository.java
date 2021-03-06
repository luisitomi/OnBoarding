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

import com.dev.op.core.dto.vipchannel.getListOnuModel;
import com.dev.op.core.mapper.vipchannel.getListOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListOnuJdbcRepository")
public class getListOnuCustomJdbcRepository implements getListOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListOnuModel> getListOnu() {
		List<getListOnuModel> getListOnu = new ArrayList<getListOnuModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTONU);
			simpleJdbcCall.returningResultSet("getListOnu", new getListOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListOnu = (List<getListOnuModel>) result.get("getListOnu");
			return getListOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
