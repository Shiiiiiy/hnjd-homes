package com.uws.home.model;
import com.uws.core.base.BaseModel;
/**
 * 门户用户信息数据包
 * @author wangjun
 */
public class MhStuUser extends BaseModel{
	/**用户 学号*/
	private String XH;
	/**用户 姓名*/
	private String XM;
	/**所在学院*/
	private String BMMC;
	/**专业名称*/
	private String ZYMC;
	/** 入学学年  */
	private String RXND;
	/** 离校学年  */
	private String LXND;
	/** 当前学年  */
	private String nowYear;
	/** 身份证号  */
	private String SFZH;

	public String getXM() {
		return XM;
	}
	public void setXM(String xM) {
		XM = xM;
	}
	public String getXH() {
		return XH;
	}
	public void setXH(String xH) {
		XH = xH;
	}
	public String getBMMC() {
		return BMMC;
	}
	public void setBMMC(String bMMC) {
		BMMC = bMMC;
	}
	public String getZYMC() {
		return ZYMC;
	}
	public void setZYMC(String zYMC) {
		ZYMC = zYMC;
	}
	public String getRXND() {
		return RXND;
	}
	public void setRXND(String rXND) {
		RXND = rXND;
	}
	public String getLXND() {
		return LXND;
	}
	public void setLXND(String lXND) {
		LXND = lXND;
	}
	public String getNowYear() {
		return nowYear;
	}
	public void setNowYear(String nowYear) {
		this.nowYear = nowYear;
	}
	public String getSFZH() {
		return SFZH;
	}
	public void setSFZH(String sFZH) {
		SFZH = sFZH;
	}
}
