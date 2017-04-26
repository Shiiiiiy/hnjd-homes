package com.uws.home.model;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

/**
 * 缴费系统的缴费项目字典
 * 
 * @ClassName: ChargeCodeModel
 * @Description: TODO
 * @author:马小东
 * @date: 2016年8月24日 09:43:36
 */
public class SynchronizedChargeCodeModel implements RowMapper, Serializable {


	/**
	 * 收费项目代码
	 */
	private String SFXMDM;

	/**
	 * 收费项目名称
	 */
	private String SFXMMC;

	public String getSFXMDM() {
		return SFXMDM;
	}

	public void setSFXMDM(String sFXMDM) {
		SFXMDM = sFXMDM;
	}

	public String getSFXMMC() {
		return SFXMMC;
	}

	public void setSFXMMC(String sFXMMC) {
		SFXMMC = sFXMMC;
	}

	@Override
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
		SynchronizedChargeCodeModel scd = new SynchronizedChargeCodeModel();
		scd.setSFXMDM(rs.getString("SFXMDM"));
		scd.setSFXMMC(rs.getString("SFXMMC"));

		return scd;
	}

}
