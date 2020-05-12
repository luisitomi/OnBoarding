package com.dev.op.core.dto.vipchannel;

import java.io.Serializable;

public class getListVoucherModel implements Serializable {

	/**
	 * call getListVoucher();
	 */
	private static final long serialVersionUID = 7440851506308938680L;

	private Integer voucher;
	
	private String name;

	public getListVoucherModel() {
		
	}

	public Integer getVoucher() {
		return voucher;
	}

	public void setVoucher(Integer voucher) {
		this.voucher = voucher;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
