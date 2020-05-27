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
import com.dev.op.core.mapper.vipchannel.putDirectionByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putDirectionByIdJdbcRepository")
public class putDirectionByIdCustomJdbcRepository implements putDirectionByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putDirectionById(String document,String code,String number,Integer zone) {
		List<ResponseModel> putDirectionById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTDIRECTIONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("number", Types.VARCHAR),
											 new SqlParameter("zone", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putDirectionById", new putDirectionByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("number", number);
			inParams.addValue("zone", zone);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putDirectionById = (List<ResponseModel>) result.get("putDirectionById");
			return putDirectionById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
