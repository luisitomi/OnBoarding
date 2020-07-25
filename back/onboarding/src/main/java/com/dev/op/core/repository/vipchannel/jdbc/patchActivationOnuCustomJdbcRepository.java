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
import com.dev.op.core.mapper.vipchannel.patchActivationOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchActivationOnuJdbcRepository")
public class patchActivationOnuCustomJdbcRepository implements patchActivationOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchActivationOnu(Integer idOnu) {
		List<ResponseModel> patchActivationOnu = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHACTIVATIONONU);
			simpleJdbcCall.declareParameters(new SqlParameter("idOnu", Types.INTEGER));
			simpleJdbcCall.returningResultSet("patchActivationOnu", new patchActivationOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("idOnu", idOnu);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchActivationOnu = (List<ResponseModel>) result.get("patchActivationOnu");
			return patchActivationOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
