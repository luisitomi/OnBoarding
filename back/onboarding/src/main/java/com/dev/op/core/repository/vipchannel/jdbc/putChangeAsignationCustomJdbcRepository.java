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
import com.dev.op.core.mapper.vipchannel.putChangeAsignationMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putChangeAsignationJdbcRepository")
public class putChangeAsignationCustomJdbcRepository implements putChangeAsignationJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putChangeAsignation(Integer notiId,Integer aigId) {
		List<ResponseModel> putChangeAsignation = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTCHANGEASIGNATION);
			simpleJdbcCall.declareParameters(new SqlParameter("notiId", Types.INTEGER),
											 new SqlParameter("aigId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("putChangeAsignation", new putChangeAsignationMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("notiId", notiId);
			inParams.addValue("aigId", aigId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putChangeAsignation = (List<ResponseModel>) result.get("putChangeAsignation");
			return putChangeAsignation;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
