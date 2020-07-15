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
import com.dev.op.core.mapper.vipchannel.patchStorageValidateMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchStorageValidateJdbcRepository")
public class patchStorageValidateCustomJdbcRepository implements patchStorageValidateJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchStorageValidate(Integer idRemision) {
		List<ResponseModel> patchStorageValidate = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHSTORAGEVALIDATE);
			simpleJdbcCall.declareParameters(new SqlParameter("idRemision", Types.INTEGER));
			simpleJdbcCall.returningResultSet("patchStorageValidate", new patchStorageValidateMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("idRemision", idRemision);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchStorageValidate = (List<ResponseModel>) result.get("patchStorageValidate");
			return patchStorageValidate;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
