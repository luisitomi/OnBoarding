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
import com.dev.op.core.mapper.vipchannel.postSaveProducMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postSaveProducJdbcRepository")
public class postSaveProducCustomJdbcRepository implements postSaveProducJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postSaveProduc(String name,String code,String description,String codeP,String medi) {
		List<ResponseModel> postSaveProduc = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTSAVEPRODUC);
			simpleJdbcCall.declareParameters(new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("description", Types.VARCHAR),
											 new SqlParameter("codeP", Types.VARCHAR),
											 new SqlParameter("medi", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postSaveProduc", new postSaveProducMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("name", name);
			inParams.addValue("code", code);
			inParams.addValue("description", description);
			inParams.addValue("codeP", codeP);
			inParams.addValue("medi", medi);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postSaveProduc = (List<ResponseModel>) result.get("postSaveProduc");
			return postSaveProduc;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
