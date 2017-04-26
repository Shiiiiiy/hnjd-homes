package com.uws.home.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

/**
 * 第三方接口缴费汇总javabean
 * 
 * @ClassName: SynchronizedChargeDetialModel
 * @Description: TODO
 * @author:马小东
 * @date: 2016年8月24日 09:43:36
 */
public class SynchronizedChargeModel implements RowMapper, Serializable {

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
	 * 收费项目名称
	 */
	private String SFXMMC;

	/**
	 * 收费项目编码
	 */
	private String SFXMDM;

	/**
	 * 应缴金额
	 */
	private BigDecimal YJJE;

	/**
	 * 实交金额
	 */
	private BigDecimal SJJE;
	/**
	 * 减免金额
	 */
	private BigDecimal JMJE;

	/**
	 * 退费金额
	 */
	private BigDecimal TFJE;

	/**
	 * 欠费金额
	 */
	private BigDecimal QFJE;

	/**
	 * 身份证号
	 */
	private String SFZH;

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

	public BigDecimal getYJJE() {
		return YJJE;
	}

	public void setYJJE(BigDecimal yJJE) {
		YJJE = yJJE;
	}

	public BigDecimal getSJJE() {
		return SJJE;
	}

	public void setSJJE(BigDecimal sJJE) {
		SJJE = sJJE;
	}

	public BigDecimal getJMJE() {
		return JMJE;
	}

	public void setJMJE(BigDecimal jMJE) {
		JMJE = jMJE;
	}

	public BigDecimal getTFJE() {
		return TFJE;
	}

	public void setTFJE(BigDecimal tFJE) {
		TFJE = tFJE;
	}

	public BigDecimal getQFJE() {
		return QFJE;
	}

	public void setQFJE(BigDecimal qFJE) {
		QFJE = qFJE;
	}

	public String getSFZH() {
		return SFZH;
	}

	public void setSFZH(String sFZH) {
		SFZH = sFZH;
	}

	public String getSFXMDM() {
		return SFXMDM;
	}

	public void setSFXMDM(String sFXMDM) {
		SFXMDM = sFXMDM;
	}

	@Override
	public Object mapRow(ResultSet rs, int rowNum) throws SQLException {

		SynchronizedChargeModel scd = new SynchronizedChargeModel();
		scd.setJMJE(rs.getBigDecimal("JMJE"));
		scd.setQFJE(rs.getBigDecimal("QFJE"));
		scd.setSFQJDM(rs.getString("SFQJDM"));
		scd.setSFXMMC(rs.getString("SFXMMC"));
		scd.setSFZH(rs.getString("SFZH"));
		scd.setSJJE(rs.getBigDecimal("SJJE"));
		scd.setTFJE(rs.getBigDecimal("TFJE"));
		scd.setXH(rs.getString("XH"));
		scd.setXM(rs.getString("XM"));
		scd.setYJJE(rs.getBigDecimal("YJJE"));
		scd.setSFXMDM(rs.getString("SFXMDM"));

		return scd;
	}
}
