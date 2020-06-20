package com.dev.op.core.repository.vipchannel.jdbc;

import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import com.dev.op.core.dto.vipchannel.returnGetContractModel;
import com.dev.op.core.util.vipchannel.Constantes;

@Repository("returnGetContractJdbcRepository")
public class returnGetContractCustomJdbcRepository implements returnGetContractJdbcRepository {

	private SimpleJdbcCall simpleJdbcCall;
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate);
	}
	
	@Override
	public returnGetContractModel returnGetContract(Integer detailId,Integer nextId) {
		
		try {
			
			simpleJdbcCall.withProcedureName(Constantes.RETURNGETCONTRACT);
			simpleJdbcCall.withoutProcedureColumnMetaDataAccess();
			simpleJdbcCall.useInParameterNames("detailId", "nextId");
			simpleJdbcCall.declareParameters(new SqlParameter("detailId", Types.INTEGER),
											 new SqlParameter("nextId", Types.INTEGER),
											 new SqlOutParameter("client", Types.VARCHAR),
											 new SqlOutParameter("email", Types.VARCHAR),
											 new SqlOutParameter("customer", Types.VARCHAR),
											 new SqlOutParameter("direction", Types.VARCHAR),
											 new SqlOutParameter("document", Types.VARCHAR));
			
			Map<String, Object> inParams = new HashMap<String, Object>();
			inParams.put("detailId", detailId);
			inParams.put("nextId", nextId);
			
			Map<String, Object> result = simpleJdbcCall.execute(inParams);
			System.out.println(result);
			
			returnGetContractModel returnGetContract = new returnGetContractModel();
			returnGetContract.setName((String) result.get("client"));
			returnGetContract.setEmail((String) result.get("email"));
			returnGetContract.setCustomer((String) result.get("customer"));
			returnGetContract.setDirection((String) result.get("direction"));
			returnGetContract.setDocument((String) result.get("document"));
			return returnGetContract;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
