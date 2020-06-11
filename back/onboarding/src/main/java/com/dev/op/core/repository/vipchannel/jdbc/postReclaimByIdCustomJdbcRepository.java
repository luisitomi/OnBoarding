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
import com.dev.op.core.mapper.vipchannel.postReclaimByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postReclaimByIdJdbcRepository")
public class postReclaimByIdCustomJdbcRepository implements postReclaimByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postReclaimById(String document,String code,Integer service,Integer reclaim,String description) {
		List<ResponseModel> postReclaimById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTRECLAIMBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("service", Types.INTEGER),
											 new SqlParameter("reclaim", Types.INTEGER),
											 new SqlParameter("description", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postReclaimById", new postReclaimByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("service", service);
			inParams.addValue("reclaim", reclaim);
			inParams.addValue("description", description);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postReclaimById = (List<ResponseModel>) result.get("postReclaimById");
			return postReclaimById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
