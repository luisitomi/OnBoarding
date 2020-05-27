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
import com.dev.op.core.mapper.vipchannel.deleteDetailCountMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("deleteDetailCountJdbcRepository")
public class deleteDetailCountCustomJdbcRepository implements deleteDetailCountJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> deleteDetailCount(String document,String code,Integer status) {
		List<ResponseModel> deleteDetailCount = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.DELETEDETAILCOUNT);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("status", Types.INTEGER));
			simpleJdbcCall.returningResultSet("deleteDetailCount", new deleteDetailCountMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("status", status);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			deleteDetailCount = (List<ResponseModel>) result.get("deleteDetailCount");
			return deleteDetailCount;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
