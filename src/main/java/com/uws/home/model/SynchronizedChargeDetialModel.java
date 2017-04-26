package com.uws.home.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

/**
 * 缴费明细表
 * 
 * @ClassName: SynchronizedChargeModel
 * @Description: TODO
 * @author:马小东
 * @date: 2016年8月24日 09:43:36
 */
public class SynchronizedChargeDetialModel implements RowMapper, Serializable {


	/**
	 * 学号
	 */
	private String XH;

	/**
	 * 姓名
	 */
	private String XM;

	/**
	 * 收费年度
	 */
	private String SFQJDM;

	/**
	 * 收费项目
	 */
	private String SFXMMC;

	/**
	 * 实交金额
	 */
	private BigDecimal SJJE;

	/**
	 * 收费日期
	 */
	private String SFRQ;

	/**
	 * 收费时间
	 */
	private String SFSJ;

	/**
	 * 身份证号
	 */
	private String SFZH;

	/**
	 * 是否同步
	 */
	private String ISCL;

	public String getXH() {
		return XH;
	}

	public void setXH(String xH) {
		XH = xH;
	}

	public String getXM() {
		return XM;
	}

	public void setXM(String xM) {
		XM = xM;
	}

	public String getSFQJDM() {
		return SFQJDM;
	}

	public void setSFQJDM(String sFQJDM) {
		SFQJDM = sFQJDM;
	}

	public String getSFXMMC() {
		return SFXMMC;
	}

	public void setSFXMMC(String sFXMMC) {
		SFXMMC = sFXMMC;
	}

	public BigDecimal getSJJE() {
		return SJJE;
	}

	public void setSJJE(BigDecimal sJJE) {
		SJJE = sJJE;
	}

	public String getSFRQ() {
		return SFRQ;
	}

	public void setSFRQ(String sFRQ) {
		SFRQ = sFRQ;
	}

	public String getSFSJ() {
		return SFSJ;
	}

	public void setSFSJ(String sFSJ) {
		SFSJ = sFSJ;
	}

	public String getSFZH() {
		return SFZH;
	}

	public void setSFZH(String sFZH) {
		SFZH = sFZH;
	}

	@Override
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
		SynchronizedChargeDetialModel scd = new SynchronizedChargeDetialModel();
		scd.setSFQJDM(rs.getString("SFQJDM"));
		scd.setSFRQ(rs.getString("SFRQ"));
		scd.setSFSJ(rs.getString("SFSJ"));
		// scd.setSFXMMC(rs.getString("SFXMMC"));
		scd.setSFZH(rs.getString("SFZH"));
		scd.setSJJE(rs.getBigDecimal("SJJE"));
		scd.setXH(rs.getString("XH"));
		scd.setXM(rs.getString("XM"));
		scd.setISCL(rs.getString("ISCL"));
		return scd;
	}

	public String getISCL() {
		return ISCL;
	}

	public void setISCL(String iSCL) {
		ISCL = iSCL;
	}

}
