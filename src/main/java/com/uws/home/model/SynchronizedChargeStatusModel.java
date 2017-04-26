package com.uws.home.model;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

/**
 * 第三方缴费接口返回的缴费状态
 * 
 * @ClassName: SynchronizedChargeModel
 * @Description: TODO
 * @author:马小东
 * @date: 2016年8月24日 09:43:36
 */
public class SynchronizedChargeStatusModel implements RowMapper, Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 学号
	 */
	private String XH;

	/**
	 * 身份证号
	 */
	private String SFZH;//数据库里是空的

	/**
	 * 缴费状态
	 */
	private String SFZT;//目前3中状态 1 2 3

	public String getXH() {
		return XH;
	}

	public void setXH(String xH) {
		XH = xH;
	}

	public String getSFZH() {
		return SFZH;
	}

	public void setSFZH(String sFZH) {
		SFZH = sFZH;
	}

	public String getSFZT() {
		return SFZT;
	}

	public void setSFZT(String sFZT) {
		SFZT = sFZT;
	}

	@Override
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
		SynchronizedChargeStatusModel scd = new SynchronizedChargeStatusModel();
		scd.setSFZH(rs.getString("SFZH"));
		scd.setXH(rs.getString("XH"));
		scd.setSFZT(rs.getString("SFZT"));

		return scd;
	}

}
