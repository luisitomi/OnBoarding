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
import com.dev.op.core.mapper.vipchannel.postSaveServiceSaleMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("postSaveServiceSaleJdbcRepository")
public class postSaveServiceSaleCustomJdbcRepository implements postSaveServiceSaleJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> postSaveServiceSale( String document,
													String code,
													String name,
													String last,
													String second,
													String client,
													String fech,
													String email,
													Integer zone,
													String number,
													String descriptionrefe,
													Integer seller,
													String fechadate,
													String timedate,
													Integer servicecount,
													String amountfirst,
													String amountsecond,
													String textins) {
		List<ResponseModel> postSaveServiceSale = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.POSTSAVESERVICESALE);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("name", Types.VARCHAR),
											 new SqlParameter("last", Types.VARCHAR),
											 new SqlParameter("second", Types.VARCHAR),
											 new SqlParameter("client", Types.VARCHAR),
											 new SqlParameter("fech", Types.DATE),
											 new SqlParameter("email", Types.VARCHAR),
											 new SqlParameter("zone", Types.INTEGER),
											 new SqlParameter("number", Types.VARCHAR),
											 new SqlParameter("descriptionrefe", Types.VARCHAR),
											 new SqlParameter("seller", Types.INTEGER),
											 new SqlParameter("fechadate", Types.DATE),
											 new SqlParameter("timedate", Types.VARCHAR),
											 new SqlParameter("servicecount", Types.INTEGER),
											 new SqlParameter("amountfirst", Types.DECIMAL),
											 new SqlParameter("amountsecond", Types.DECIMAL),
											 new SqlParameter("textins", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("postSaveServiceSale", new postSaveServiceSaleMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("name", name);
			inParams.addValue("last", last);
			inParams.addValue("second", second);
			inParams.addValue("client", client);
			inParams.addValue("fech", fech);
			inParams.addValue("zone", zone);
			inParams.addValue("number", number);
			inParams.addValue("descriptionrefe", descriptionrefe);
			inParams.addValue("seller", seller);
			inParams.addValue("fechadate", fechadate);
			inParams.addValue("timedate", timedate);
			inParams.addValue("servicecount", servicecount);
			inParams.addValue("amountfirst", amountfirst);
			inParams.addValue("amountsecond", amountsecond);
			inParams.addValue("textins", textins);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			postSaveServiceSale = (List<ResponseModel>) result.get("postSaveServiceSale");
			return postSaveServiceSale;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
