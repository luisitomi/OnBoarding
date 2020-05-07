package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;

public class getVoucherByIdMapper implements RowMapper<getVoucherByIdModel> {
	
	@Override
	public getVoucherByIdModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getVoucherByIdModel getVoucherById = new getVoucherByIdModel();
		getVoucherById.setVoucherId(rs.getInt("voucherId"));
		getVoucherById.setVoucher(rs.getString("voucher"));
		getVoucherById.setName(rs.getString("name"));
		getVoucherById.setService(rs.getInt("service"));
		return getVoucherById;
	}
}
