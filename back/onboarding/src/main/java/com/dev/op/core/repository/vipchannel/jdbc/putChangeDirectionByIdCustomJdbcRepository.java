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
import com.dev.op.core.mapper.vipchannel.putChangeDirectionByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putChangeDirectionByIdJdbcRepository")
public class putChangeDirectionByIdCustomJdbcRepository implements putChangeDirectionByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putChangeDirectionById(String document,String code,String number,Integer zone,String reference) {
		List<ResponseModel> putChangeDirectionById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTCHANGEDIRECTIONBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("number", Types.VARCHAR),
											 new SqlParameter("zone", Types.INTEGER),
											 new SqlParameter("reference", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("putChangeDirectionById", new putChangeDirectionByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("number", number);
			inParams.addValue("zone", zone);
			inParams.addValue("reference", reference);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putChangeDirectionById = (List<ResponseModel>) result.get("putChangeDirectionById");
			return putChangeDirectionById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
