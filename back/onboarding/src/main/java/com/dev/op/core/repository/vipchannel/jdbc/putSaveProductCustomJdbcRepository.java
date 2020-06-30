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
import com.dev.op.core.mapper.vipchannel.putSaveProductMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("putSaveProductJdbcRepository")
public class putSaveProductCustomJdbcRepository implements putSaveProductJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> putSaveProduct(Integer producId,String name,String code,String description,String codeP,String medi) {
		List<ResponseModel> putSaveProduct = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PUTSAVEPRODUCT);
			simpleJdbcCall.declareParameters(new SqlParameter("producId", Types.INTEGER),
											 new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("description", Types.VARCHAR),
											 new SqlParameter("codeP", Types.VARCHAR),
											 new SqlParameter("medi", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("putSaveProduct", new putSaveProductMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("producId", producId);
			inParams.addValue("name", name);
			inParams.addValue("code", code);
			inParams.addValue("description", description);
			inParams.addValue("codeP", codeP);
			inParams.addValue("medi", medi);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			putSaveProduct = (List<ResponseModel>) result.get("putSaveProduct");
			return putSaveProduct;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
