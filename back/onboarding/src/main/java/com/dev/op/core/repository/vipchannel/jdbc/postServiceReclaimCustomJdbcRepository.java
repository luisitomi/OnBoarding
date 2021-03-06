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
import com.dev.op.core.mapper.vipchannel.postServiceReclaimMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postServiceReclaimJdbcRepository")
public class postServiceReclaimCustomJdbcRepository implements postServiceReclaimJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postServiceReclaim(Integer detaiId,Integer tec,String description, Integer mateId,Integer counts) {
		List<ResponseModel> postServiceReclaim = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTSERVICERECLAIM);
			simpleJdbcCall.declareParameters(new SqlParameter("nextId", Types.INTEGER),
											 new SqlParameter("tec", Types.INTEGER),
											 new SqlParameter("description", Types.VARCHAR),
											 new SqlParameter("mateId", Types.INTEGER),
											 new SqlParameter("counts", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postServiceReclaim", new postServiceReclaimMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("detaiId", detaiId);
			inParams.addValue("tec", tec);
			inParams.addValue("description", description);
			inParams.addValue("mateId", mateId);
			inParams.addValue("counts", counts);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postServiceReclaim = (List<ResponseModel>) result.get("postServiceReclaim");
			return postServiceReclaim;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
