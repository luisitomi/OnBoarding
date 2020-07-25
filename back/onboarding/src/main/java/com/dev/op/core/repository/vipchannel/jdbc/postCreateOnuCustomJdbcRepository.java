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
import com.dev.op.core.mapper.vipchannel.postCreateOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postCreateOnuJdbcRepository")
public class postCreateOnuCustomJdbcRepository implements postCreateOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postCreateOnu(String nameSerie,String namemac,String nameId,String namePass) {
		List<ResponseModel> postCreateOnu = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTCREATEONU);
			simpleJdbcCall.declareParameters(new SqlParameter("nameSerie", Types.VARCHAR),
										 	 new SqlParameter("namemac", Types.VARCHAR),
											 new SqlParameter("nameId", Types.VARCHAR),
											 new SqlParameter("namePass", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postCreateOnu", new postCreateOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("nameSerie", nameSerie);
			inParams.addValue("namemac", namemac);
			inParams.addValue("nameId", nameId);
			inParams.addValue("namePass", namePass);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postCreateOnu = (List<ResponseModel>) result.get("postCreateOnu");
			return postCreateOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
