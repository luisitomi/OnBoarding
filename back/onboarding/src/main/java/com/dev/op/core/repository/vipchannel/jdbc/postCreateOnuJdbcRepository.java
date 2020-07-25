package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.ResponseModel;

public interface postCreateOnuJdbcRepository {
	List<ResponseModel> postCreateOnu(String nameSerie,String namemac,String nameId,String namePass);
}
