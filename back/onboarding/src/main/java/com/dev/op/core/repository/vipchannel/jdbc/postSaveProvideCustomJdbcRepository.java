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
import com.dev.op.core.mapper.vipchannel.postSaveProvideMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postSaveProvideJdbcRepository")
public class postSaveProvideCustomJdbcRepository implements postSaveProvideJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postSaveProvide(String name) {
		List<ResponseModel> postSaveProvide = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTSAVEPROVIDE);
			simpleJdbcCall.declareParameters(new SqlParameter("name", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postSaveProvide", new postSaveProvideMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("name", name);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postSaveProvide = (List<ResponseModel>) result.get("postSaveProvide");
			return postSaveProvide;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
