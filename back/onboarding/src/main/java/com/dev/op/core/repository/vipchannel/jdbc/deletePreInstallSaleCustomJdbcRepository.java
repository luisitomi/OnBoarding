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
import com.dev.op.core.mapper.vipchannel.deletePreInstallSaleMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("deletePreInstallSaleJdbcRepository")
public class deletePreInstallSaleCustomJdbcRepository implements deletePreInstallSaleJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> deletePreInstallSale(Integer detail,Integer next,String description) {
		List<ResponseModel> deletePreInstallSale = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.DELETEPREINSTALLSALE);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("status", Types.INTEGER));
			simpleJdbcCall.returningResultSet("deletePreInstallSale", new deletePreInstallSaleMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("detail", detail);
			inParams.addValue("next", next);
			inParams.addValue("description", description);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			deletePreInstallSale = (List<ResponseModel>) result.get("deletePreInstallSale");
			return deletePreInstallSale;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
