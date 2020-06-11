package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListManagerReportModel;

public class getListManagerReportMapper implements RowMapper<getListManagerReportModel> {
	
	@Override
	public getListManagerReportModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListManagerReportModel getListManagerReport = new getListManagerReportModel();
		getListManagerReport.setCode(rs.getString("code"));
		getListManagerReport.setClient(rs.getString("client"));
		getListManagerReport.setDirection(rs.getString("name") + " " + rs.getString("number"));
		getListManagerReport.setService(rs.getString("service"));
		getListManagerReport.setMin(rs.getString("min"));
		getListManagerReport.setMax(rs.getString("max"));
		getListManagerReport.setAmount(rs.getString("amount"));
		return getListManagerReport;
	}
}
