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

import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.mapper.vipchannel.getDirectionByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getDirectionByIdJdbcRepository")
public class getDirectionByIdCustomJdbcRepository implements getDirectionByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getDirectionByIdModel> getDirectionById(String document,String code) {
		List<getDirectionByIdModel> getDirectionById = new ArrayList<getDirectionByIdModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETDIRECTIONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getDirectionById", new getDirectionByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getDirectionById = (List<getDirectionByIdModel>) result.get("getDirectionById");
			return getDirectionById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
