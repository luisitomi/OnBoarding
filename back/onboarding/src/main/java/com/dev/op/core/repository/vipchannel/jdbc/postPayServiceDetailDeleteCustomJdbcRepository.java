package com.dev.op.core.repository.vipchannel.jdbc;

import java.math.BigDecimal;
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
import com.dev.op.core.mapper.vipchannel.postPayServiceDetailDeleteMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postPayServiceDetailDeleteJdbcRepository")
public class postPayServiceDetailDeleteCustomJdbcRepository implements postPayServiceDetailDeleteJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postPayServiceDetailDelete(String document,String code,BigDecimal amount,Integer managerId,Integer serviceId,Integer typeId,Integer user) {
		List<ResponseModel> postPayServiceDetailDelete = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTPAYSERVICEDETAILDELETE);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("amount", Types.DECIMAL),
											 new SqlParameter("managerId", Types.INTEGER),
											 new SqlParameter("serviceId", Types.INTEGER),
											 new SqlParameter("typeId", Types.INTEGER),
											 new SqlParameter("user", Types.INTEGER));
			simpleJdbcCall.returningResultSet("postPayServiceDetailDelete", new postPayServiceDetailDeleteMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("amount", amount);
			inParams.addValue("managerId", managerId);
			inParams.addValue("serviceId", serviceId);
			inParams.addValue("typeId", typeId);
			inParams.addValue("user", user);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postPayServiceDetailDelete = (List<ResponseModel>) result.get("postPayServiceDetailDelete");
			return postPayServiceDetailDelete;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
