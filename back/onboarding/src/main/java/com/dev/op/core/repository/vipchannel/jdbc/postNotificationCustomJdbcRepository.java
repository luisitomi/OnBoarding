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

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.mapper.vipchannel.postNotificationMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postNotificationJdbcRepository")
public class postNotificationCustomJdbcRepository implements postNotificationJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postNotification(Integer module,Integer codeUser,String document,String client,String asunt) {
		List<ResponseModel> postNotification = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTNOTIFICATION);
			simpleJdbcCall.declareParameters(new SqlParameter("module", Types.INTEGER),
											 new SqlParameter("codeUser", Types.INTEGER),
											 new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("client", Types.VARCHAR),
											 new SqlParameter("asunt", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postNotification", new postNotificationMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("module", module);
			inParams.addValue("codeUser", codeUser);
			inParams.addValue("document", document);
			inParams.addValue("client", client);
			inParams.addValue("asunt", asunt);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postNotification = (List<ResponseModel>) result.get("postNotification");
			return postNotification;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
