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

import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.mapper.vipchannel.getPayServiceDetailMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getPayServiceDetailJdbcRepository")
public class getPayServiceDetailCustomJdbcRepository implements getPayServiceDetailJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getPayServiceDetailModel> getPayServiceDetail(String document,String code) {
		List<getPayServiceDetailModel> getPayServiceDetail = new ArrayList<getPayServiceDetailModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPAYSERVICEDETAIL);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getPayServiceDetail", new getPayServiceDetailMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getPayServiceDetail = (List<getPayServiceDetailModel>) result.get("getPayServiceDetail");
			return getPayServiceDetail;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
