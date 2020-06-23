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
import com.dev.op.core.mapper.vipchannel.postMaterialMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postMaterialJdbcRepository")
public class postMaterialCustomJdbcRepository implements postMaterialJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postMaterial(String name) {
		List<ResponseModel> postMaterial = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTMATERIAL);
			simpleJdbcCall.declareParameters(new SqlParameter("name", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postMaterial", new postMaterialMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("name", name);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postMaterial = (List<ResponseModel>) result.get("postMaterial");
			return postMaterial;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
