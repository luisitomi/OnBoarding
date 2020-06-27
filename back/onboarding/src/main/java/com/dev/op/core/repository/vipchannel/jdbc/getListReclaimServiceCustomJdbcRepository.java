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

import com.dev.op.core.dto.vipchannel.getListReclaimServiceModel;
import com.dev.op.core.mapper.vipchannel.getListReclaimServiceMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListReclaimServiceJdbcRepository")
public class getListReclaimServiceCustomJdbcRepository implements getListReclaimServiceJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListReclaimServiceModel> getListReclaimService(Integer codeint) {
		List<getListReclaimServiceModel> getListReclaimService = new ArrayList<getListReclaimServiceModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTRECLAIMSERVICE);
			simpleJdbcCall.declareParameters(new SqlParameter("codeint", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListReclaimService", new getListReclaimServiceMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("codeint", codeint);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListReclaimService = (List<getListReclaimServiceModel>) result.get("getListReclaimService");
			return getListReclaimService;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
