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

import com.dev.op.core.dto.vipchannel.getNotificationModel;
import com.dev.op.core.mapper.vipchannel.getNotificationMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getNotificationJdbcRepository")
public class getNotificationCustomJdbcRepository implements getNotificationJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getNotificationModel> getNotification(String user) {
		List<getNotificationModel> getNotification = new ArrayList<getNotificationModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETNOTIFICATION);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getNotification", new getNotificationMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getNotification = (List<getNotificationModel>) result.get("getNotification");
			return getNotification;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
