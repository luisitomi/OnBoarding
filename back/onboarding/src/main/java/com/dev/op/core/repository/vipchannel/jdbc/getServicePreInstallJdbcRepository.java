package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getServicePreInstallModel;

public interface getServicePreInstallJdbcRepository {
	List<getServicePreInstallModel> getServicePreInstall(Integer codeid,String datei,String datef);
}
