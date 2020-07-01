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

import com.dev.op.core.dto.vipchannel.getListCountOnuModel;
import com.dev.op.core.mapper.vipchannel.getListCountOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListCountOnuJdbcRepository")
public class getListCountOnuCustomJdbcRepository implements getListCountOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListCountOnuModel> getListCountOnu(Integer detalleIds,Integer nextids) {
		List<getListCountOnuModel> getListCountOnu = new ArrayList<getListCountOnuModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTCOUNTONU);
			simpleJdbcCall.declareParameters(new SqlParameter("detalleIds", Types.INTEGER),
											 new SqlParameter("nextids", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListCountOnu", new getListCountOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("detalleIds", detalleIds);
			inParams.addValue("nextids", nextids);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListCountOnu = (List<getListCountOnuModel>) result.get("getListCountOnu");
			return getListCountOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
