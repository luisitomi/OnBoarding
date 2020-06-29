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
import com.dev.op.core.mapper.vipchannel.postRemisionMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postRemisionJdbcRepository")
public class postRemisionCustomJdbcRepository implements postRemisionJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postRemision(Integer options,Integer typeRemi,Integer producId,Integer providerId,Integer counts,String conditions,String autorize,Integer codeuser) {
		List<ResponseModel> postRemision = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTREMISION);
			simpleJdbcCall.declareParameters(new SqlParameter("options", Types.INTEGER),
											 new SqlParameter("typeRemi", Types.INTEGER),
											 new SqlParameter("producId", Types.INTEGER),
											 new SqlParameter("providerId", Types.INTEGER),
											 new SqlParameter("counts", Types.INTEGER),
											 new SqlParameter("conditions", Types.VARCHAR),
											 new SqlParameter("autorize", Types.VARCHAR),
											 new SqlParameter("asunt", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postRemision", new postRemisionMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("options", options);
			inParams.addValue("typeRemi", typeRemi);
			inParams.addValue("producId", producId);
			inParams.addValue("providerId", providerId);
			inParams.addValue("counts", counts);
			inParams.addValue("conditions", conditions);
			inParams.addValue("autorize", autorize);
			inParams.addValue("codeuser", codeuser);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postRemision = (List<ResponseModel>) result.get("postRemision");
			return postRemision;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
