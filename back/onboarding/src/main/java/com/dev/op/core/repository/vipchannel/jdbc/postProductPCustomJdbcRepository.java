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
import com.dev.op.core.mapper.vipchannel.postProductPMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postProductPJdbcRepository")
public class postProductPCustomJdbcRepository implements postProductPJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postProductP(Integer productId,Integer provideId,String price) {
		List<ResponseModel> postProductP = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTPRODUCTP);
			simpleJdbcCall.declareParameters(new SqlParameter("productId", Types.INTEGER),
											 new SqlParameter("provideId", Types.INTEGER),
											 new SqlParameter("price", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postProductP", new postProductPMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("productId", productId);
			inParams.addValue("provideId", provideId);
			inParams.addValue("price", price);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postProductP = (List<ResponseModel>) result.get("postProductP");
			return postProductP;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
