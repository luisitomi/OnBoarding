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

import com.dev.op.core.dto.vipchannel.getListManagerReportModel;
import com.dev.op.core.mapper.vipchannel.getListManagerReportMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getListManagerReportJdbcRepository")
public class getListManagerReportCustomJdbcRepository implements getListManagerReportJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getListManagerReportModel> getListManagerReport(Integer manager) {
		List<getListManagerReportModel> getListManagerReport = new ArrayList<getListManagerReportModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETLISTMANAGERREPORT);
			simpleJdbcCall.declareParameters(new SqlParameter("manager", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getListManagerReport", new getListManagerReportMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("manager", manager);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getListManagerReport = (List<getListManagerReportModel>) result.get("getListManagerReport");
			return getListManagerReport;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
