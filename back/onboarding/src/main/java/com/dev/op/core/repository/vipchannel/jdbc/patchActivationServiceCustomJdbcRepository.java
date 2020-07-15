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
import com.dev.op.core.mapper.vipchannel.patchActivationServiceMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchActivationServiceJdbcRepository")
public class patchActivationServiceCustomJdbcRepository implements patchActivationServiceJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchActivationService(Integer activationId,String dateinfo) {
		List<ResponseModel> patchActivationService = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHACTIVATIONSERVICE);
			simpleJdbcCall.declareParameters(new SqlParameter("activationId", Types.INTEGER),
											 new SqlParameter("dateinfo", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("patchActivationService", new patchActivationServiceMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("activationId", activationId);
			inParams.addValue("dateinfo", dateinfo);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchActivationService = (List<ResponseModel>) result.get("patchActivationService");
			return patchActivationService;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
