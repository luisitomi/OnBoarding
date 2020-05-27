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
import com.dev.op.core.mapper.vipchannel.patchManagerByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchManagerByIdJdbcRepository")
public class patchManagerByIdCustomJdbcRepository implements patchManagerByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchManagerById(String document,String code,Integer code_manager) {
		List<ResponseModel> patchManagerById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHMANAGERBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("code_manager", Types.INTEGER));
			simpleJdbcCall.returningResultSet("patchManagerById", new patchManagerByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("code_manager", code_manager);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchManagerById = (List<ResponseModel>) result.get("patchManagerById");
			return patchManagerById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
