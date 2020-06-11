package com.dev.op.core.repository.vipchannel.jdbc;

import java.util.List;

import com.dev.op.core.dto.vipchannel.getReclaimStatusModel;

public interface getReclaimStatusJdbcRepository {
	List<getReclaimStatusModel> getReclaimStatus(String datei,String datef);
}