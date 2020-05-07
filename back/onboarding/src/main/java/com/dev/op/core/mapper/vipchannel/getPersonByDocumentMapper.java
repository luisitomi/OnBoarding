package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;

public class getPersonByDocumentMapper implements RowMapper<getPersonByDocumentModel> {
	
	@Override
	public getPersonByDocumentModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getPersonByDocumentModel getPersonByDocument = new getPersonByDocumentModel();
		getPersonByDocument.setDocument(rs.getString("document"));
		getPersonByDocument.setClient(rs.getString("client"));
		getPersonByDocument.setCode(rs.getString("code"));
		getPersonByDocument.setDirection(rs.getString("direction"));
		getPersonByDocument.setReference(rs.getString("reference"));
		return getPersonByDocument;
	}
}
