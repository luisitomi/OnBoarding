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
import com.dev.op.core.mapper.vipchannel.patchPasswordOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchPasswordOnuJdbcRepository")
public class patchPasswordOnuCustomJdbcRepository implements patchPasswordOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchPasswordOnu(Integer idOnu,String nameId,String namePass) {
		List<ResponseModel> patchPasswordOnu = new ArrayList<ResponseModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHPASSWORDONU);
			simpleJdbcCall.declareParameters(new SqlParameter("idOnu", Types.INTEGER),
										 	 new SqlParameter("nameId", Types.VARCHAR),
											 new SqlParameter("namePass", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("patchPasswordOnu", new patchPasswordOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("idOnu", idOnu);
			inParams.addValue("nameId", nameId);
			inParams.addValue("namePass", namePass);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchPasswordOnu = (List<ResponseModel>) result.get("patchPasswordOnu");
			return patchPasswordOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
