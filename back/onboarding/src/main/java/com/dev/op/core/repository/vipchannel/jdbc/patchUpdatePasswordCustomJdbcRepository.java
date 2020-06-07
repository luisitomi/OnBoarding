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
import com.dev.op.core.mapper.vipchannel.patchUpdatePasswordMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchUpdatePasswordJdbcRepository")
public class patchUpdatePasswordCustomJdbcRepository implements patchUpdatePasswordJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchUpdatePassword(String user,String pass) {
		List<ResponseModel> patchUpdatePassword = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHUPDATEPASSWORD);
			simpleJdbcCall.declareParameters(new SqlParameter("user", Types.VARCHAR),
											 new SqlParameter("pass", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("patchUpdatePassword", new patchUpdatePasswordMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("user", user);
			inParams.addValue("pass", pass);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchUpdatePassword = (List<ResponseModel>) result.get("patchUpdatePassword");
			return patchUpdatePassword;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
