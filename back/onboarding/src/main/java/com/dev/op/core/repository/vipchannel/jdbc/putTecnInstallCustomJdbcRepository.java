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
import com.dev.op.core.mapper.vipchannel.putTecnInstallMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putTecnInstallJdbcRepository")
public class putTecnInstallCustomJdbcRepository implements putTecnInstallJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putTecnInstall(Integer optionI,Integer tecn,Integer idP,Integer nextId) {
		List<ResponseModel> putTecnInstall = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTTECNINSTALL);
			simpleJdbcCall.declareParameters(new SqlParameter("optionI", Types.INTEGER),
											 new SqlParameter("tecn", Types.INTEGER),
											 new SqlParameter("idP", Types.INTEGER),
											 new SqlParameter("nextId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putTecnInstall", new putTecnInstallMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("optionI", optionI);
			inParams.addValue("tecn", tecn);
			inParams.addValue("idP", idP);
			inParams.addValue("nextId", nextId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putTecnInstall = (List<ResponseModel>) result.get("putTecnInstall");
			return putTecnInstall;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
