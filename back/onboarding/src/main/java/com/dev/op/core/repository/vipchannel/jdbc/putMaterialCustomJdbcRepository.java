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
import com.dev.op.core.mapper.vipchannel.putMaterialMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putMaterialJdbcRepository")
public class putMaterialCustomJdbcRepository implements putMaterialJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putMaterial(String name,Integer idMaterial) {
		List<ResponseModel> putMaterial = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTMATERIAL);
			simpleJdbcCall.declareParameters(new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("idMaterial", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putMaterial", new putMaterialMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("name", name);
			inParams.addValue("idMaterial", idMaterial);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putMaterial = (List<ResponseModel>) result.get("putMaterial");
			return putMaterial;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
