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

import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.mapper.vipchannel.getPersonByDocumentMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getPersonByDocumentJdbcRepository")
public class getPersonByDocumentCustomJdbcRepository implements getPersonByDocumentJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getPersonByDocumentModel> getPersonByDocument(String search) {
		List<getPersonByDocumentModel> getPersonByDocument = new ArrayList<getPersonByDocumentModel>();

		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETPERSONBYDOCUMENT);
			simpleJdbcCall.declareParameters(new SqlParameter("search", Types.VARCHAR));
			simpleJdbcCall.returningResultSet("getPersonByDocument", new getPersonByDocumentMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("search", search);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getPersonByDocument = (List<getPersonByDocumentModel>) result.get("getPersonByDocument");
			return getPersonByDocument;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
