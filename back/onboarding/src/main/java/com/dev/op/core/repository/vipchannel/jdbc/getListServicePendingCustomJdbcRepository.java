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

import com.dev.op.core.dto.vipchannel.getListServicePendingModel;
import com.dev.op.core.mapper.vipchannel.getListServicePendingMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListServicePendingJdbcRepository")
public class getListServicePendingCustomJdbcRepository implements getListServicePendingJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListServicePendingModel> getListServicePending(Integer codeUser) {
		List<getListServicePendingModel> getListServicePending = new ArrayList<getListServicePendingModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTSERVICEPENDING);
			simpleJdbcCall.declareParameters(new SqlParameter("codeUser", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListServicePending", new getListServicePendingMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("codeUser", codeUser);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListServicePending = (List<getListServicePendingModel>) result.get("getListServicePending");
			return getListServicePending;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
