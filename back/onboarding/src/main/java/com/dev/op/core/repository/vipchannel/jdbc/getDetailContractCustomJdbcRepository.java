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

import com.dev.op.core.dto.vipchannel.getDetailContractModel;
import com.dev.op.core.mapper.vipchannel.getDetailContractMapper;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("getDetailContractJdbcRepository")
public class getDetailContractCustomJdbcRepository implements getDetailContractJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<getDetailContractModel> getDetailContract(Integer detailId,Integer nextId) {
		List<getDetailContractModel> getDetailContract = new ArrayList<getDetailContractModel>();
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.GETDETAILCONTRACT);
			simpleJdbcCall.declareParameters(new SqlParameter("detailId", Types.INTEGER),
											 new SqlParameter("nextId", Types.INTEGER));
			simpleJdbcCall.returningResultSet("getDetailContract", new getDetailContractMapper());
			
			MapSqlParameterSource inParams = new MapSqlParameterSource();
			inParams.addValue("detailId", detailId);
			inParams.addValue("nextId", nextId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			getDetailContract = (List<getDetailContractModel>) result.get("getDetailContract");
			return getDetailContract;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
