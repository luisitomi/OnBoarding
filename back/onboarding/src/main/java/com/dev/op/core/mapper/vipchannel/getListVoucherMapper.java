package com.dev.op.core.mapper.vipchannel;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.dev.op.core.dto.vipchannel.getListVoucherModel;

public class getListVoucherMapper implements RowMapper<getListVoucherModel> {
	
	@Override
	public getListVoucherModel mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		getListVoucherModel getListVoucher = new getListVoucherModel();
		getListVoucher.setVoucher(rs.getInt("voucher"));
		getListVoucher.setName(rs.getString("name"));
		return getListVoucher;
	}
}
