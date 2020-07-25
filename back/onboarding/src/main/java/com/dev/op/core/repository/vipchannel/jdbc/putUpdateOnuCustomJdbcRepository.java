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
import com.dev.op.core.mapper.vipchannel.putUpdateOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putUpdateOnuJdbcRepository")
public class putUpdateOnuCustomJdbcRepository implements putUpdateOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putUpdateOnu(Integer idOnu,String nameSerie,String namemac) {
		List<ResponseModel> putUpdateOnu = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTUPDATEONU);
			simpleJdbcCall.declareParameters(new SqlParameter("idOnu", Types.INTEGER),
										 	 new SqlParameter("nameSerie", Types.VARCHAR),
											 new SqlParameter("namemac", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("putUpdateOnu", new putUpdateOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("idOnu", idOnu);
			inParams.addValue("nameSerie", nameSerie);
			inParams.addValue("namemac", namemac);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putUpdateOnu = (List<ResponseModel>) result.get("putUpdateOnu");
			return putUpdateOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}