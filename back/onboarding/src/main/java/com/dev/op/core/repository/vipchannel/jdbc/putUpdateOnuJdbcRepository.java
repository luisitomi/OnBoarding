package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface putUpdateOnuJdbcRepository {
	List<ResponseModel> putUpdateOnu(Integer idOnu,String nameSerie,String namemac);
}
