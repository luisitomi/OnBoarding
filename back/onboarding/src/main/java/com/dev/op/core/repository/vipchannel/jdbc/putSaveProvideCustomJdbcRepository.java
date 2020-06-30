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
import com.dev.op.core.mapper.vipchannel.putSaveProvideMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putSaveProvideJdbcRepository")
public class putSaveProvideCustomJdbcRepository implements putSaveProvideJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putSaveProvide(String name,Integer provideId) {
		List<ResponseModel> putSaveProvide = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTSAVEPROVIDE);
			simpleJdbcCall.declareParameters(new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("provideId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putSaveProvide", new putSaveProvideMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("name", name);
			inParams.addValue("provideId", provideId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putSaveProvide = (List<ResponseModel>) result.get("putSaveProvide");
			return putSaveProvide;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
