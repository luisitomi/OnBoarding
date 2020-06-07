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

import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;
import com.dev.op.core.mapper.vipchannel.getServicePreInstallMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getServicePreInstallJdbcRepository")
public class getServicePreInstallCustomJdbcRepository implements getServicePreInstallJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getServicePreInstallModel> getServicePreInstall(Integer codeid,String datei,String datef) {
		List<getServicePreInstallModel> getServicePreInstall = new ArrayList<getServicePreInstallModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETSERVICEPREINSTALL);
			simpleJdbcCall.declareParameters(new SqlParameter("codeid", Types.INTEGER),
											 new SqlParameter("datei", Types.VARCHAR),
					 						 new SqlParameter("datef", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getServicePreInstall", new getServicePreInstallMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("codeid", codeid);
			inParams.addValue("datei", datei);
			inParams.addValue("datef", datef);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getServicePreInstall = (List<getServicePreInstallModel>) result.get("getServicePreInstall");
			return getServicePreInstall;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
