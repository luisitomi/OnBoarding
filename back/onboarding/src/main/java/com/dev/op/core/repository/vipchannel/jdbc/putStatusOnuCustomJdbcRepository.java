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
import com.dev.op.core.mapper.vipchannel.putStatusOnuMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putStatusOnuJdbcRepository")
public class putStatusOnuCustomJdbcRepository implements putStatusOnuJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putStatusOnu(Integer idOnu,Integer optio,Integer idPk,Integer nextId, String description,Integer statusOnu) {
		List<ResponseModel> putStatusOnu = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTSTATUSONU);
			simpleJdbcCall.declareParameters(new SqlParameter("idOnu", Types.INTEGER),
											 new SqlParameter("optio", Types.INTEGER),
											 new SqlParameter("idPk", Types.INTEGER),
											 new SqlParameter("nextId", Types.INTEGER),
											 new SqlParameter("description", Types.VARCHAR),
											 new SqlParameter("statusOnu", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putStatusOnu", new putStatusOnuMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("idOnu", idOnu);
			inParams.addValue("optio", optio);
			inParams.addValue("idPk", idPk);
			inParams.addValue("nextId", nextId);
			inParams.addValue("description", description);
			inParams.addValue("statusOnu", statusOnu);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putStatusOnu = (List<ResponseModel>) result.get("putStatusOnu");
			return putStatusOnu;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
