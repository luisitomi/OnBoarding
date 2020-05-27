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
import com.dev.op.core.mapper.vipchannel.patchVoucherByIdMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("patchVoucherByIdJdbcRepository")
public class patchVoucherByIdCustomJdbcRepository implements patchVoucherByIdJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ResponseModel> patchVoucherById(String document,String code,Integer voucher,Integer service) {
		List<ResponseModel> patchVoucherById = new ArrayList<ResponseModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.PATCHVOUCHERBYID);
			simpleJdbcCall.declareParameters(new SqlParameter("document", Types.VARCHAR),
											 new SqlParameter("code", Types.VARCHAR),
											 new SqlParameter("voucher", Types.INTEGER),
											 new SqlParameter("service", Types.INTEGER));
			simpleJdbcCall.returningResultSet("patchVoucherById", new patchVoucherByIdMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("document", document);
			inParams.addValue("code", code);
			inParams.addValue("voucher", voucher);
			inParams.addValue("service", service);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			patchVoucherById = (List<ResponseModel>) result.get("patchVoucherById");
			return patchVoucherById;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
