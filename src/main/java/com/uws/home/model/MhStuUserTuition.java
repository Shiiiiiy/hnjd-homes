package com.uws.home.model;
import java.math.BigDecimal;

import com.uws.core.base.BaseModel;
/**
 * 门户用户信息数据包
 * @author wangjun
 */
public class MhStuUserTuition extends BaseModel{
	/** 学年  */
	private String year;
	/** 缴费状态描述  */
	private String result;//部分缴费  未交费    已缴清
	/** 应缴金额	 学费*/
	private BigDecimal YJ1;
	/**	实交金额	 学费*/
	private BigDecimal SJ1;
	/**	减免金额	 学费*/
	private BigDecimal JM1;
	/**	欠费金额	 学费*/
	private BigDecimal QF1;
	
	/** 应缴金额	 课本费 即 教材费*/
	private BigDecimal YJ2;
	/**	实交金额	 课本费*/
	private BigDecimal SJ2;
	/**	减免金额	 课本费*/
	private BigDecimal JM2;
	/**	欠费金额	 课本费*/
	private BigDecimal QF2;
	
	/** 应缴金额	 住宿费*/
	private BigDecimal YJ3;
	/**	实交金额	 住宿费*/
	private BigDecimal SJ3;
	/**	减免金额	 住宿费*/
	private BigDecimal JM3;
	/**	欠费金额	 住宿费*/
	private BigDecimal QF3;
	
	/** 应缴金额	 汇总*/
	private BigDecimal YJ;
	/**	实交金额	 汇总*/
	private BigDecimal SJ;
	/**	减免金额	 汇总*/
	private BigDecimal JM;
	/**	欠费金额	 汇总*/
	private BigDecimal QF;
	/**计算汇总用的方法*/
	public void sumAll() {
//		this.YJ=YJ1.add(YJ2).add(YJ3);
//		this.SJ=SJ1.add(SJ2).add(SJ3);
//		this.JM=JM1.add(JM2).add(JM3);
//		this.QF=QF1.add(QF2).add(QF3);
		this.YJ=new BigDecimal(YJ1.doubleValue()+YJ2.doubleValue()+YJ3.doubleValue());
		this.SJ=new BigDecimal(SJ1.doubleValue()+SJ2.doubleValue()+SJ3.doubleValue());
		this.JM=new BigDecimal(JM1.doubleValue()+JM2.doubleValue()+JM3.doubleValue());
		this.QF=new BigDecimal(QF1.doubleValue()+QF2.doubleValue()+QF3.doubleValue());
	}

	/**计算  当前是否缴清*/
	public void theState() {
		this.result="异常";
		if(YJ.doubleValue()-JM.doubleValue()==0.0){
			this.result="已缴清";return;
		}
		if(YJ.doubleValue()-JM.doubleValue()>0.0 && SJ.doubleValue()==0.0){
			this.result="未缴费";return;
		}
		double qianfei=YJ.doubleValue()-JM.doubleValue()-SJ.doubleValue();
		if(qianfei==0.0){
			this.result="已缴清";
		}else if(qianfei >0.0){
			this.result="部分缴费";
		}
	}
	//get方法
	public MhStuUserTuition(){
		this.year = "";
		this.result = "异常";
		YJ1 = new BigDecimal(0.0);
		SJ1 = new BigDecimal(0.0);
		JM1 = new BigDecimal(0.0);
		QF1 = new BigDecimal(0.0);
		YJ2 = new BigDecimal(0.0);
		SJ2 = new BigDecimal(0.0);
		JM2 = new BigDecimal(0.0);
		QF2 = new BigDecimal(0.0);
		YJ3 = new BigDecimal(0.0);
		SJ3 = new BigDecimal(0.0);
		JM3 = new BigDecimal(0.0);
		QF3 = new BigDecimal(0.0);
		YJ = new BigDecimal(0.0);
		SJ = new BigDecimal(0.0);
		JM = new BigDecimal(0.0);
		QF = new BigDecimal(0.0);
	}
	public MhStuUserTuition(String year, String result, BigDecimal yJ1,
			BigDecimal sJ1, BigDecimal jM1, BigDecimal qF1, BigDecimal yJ2,
			BigDecimal sJ2, BigDecimal jM2, BigDecimal qF2, BigDecimal yJ3,
			BigDecimal sJ3, BigDecimal jM3, BigDecimal qF3, BigDecimal yJ,
			BigDecimal sJ, BigDecimal jM, BigDecimal qF) {
		super();
		this.year = year;
		this.result = result;
		YJ1 = yJ1;
		SJ1 = sJ1;
		JM1 = jM1;
		QF1 = qF1;
		YJ2 = yJ2;
		SJ2 = sJ2;
		JM2 = jM2;
		QF2 = qF2;
		YJ3 = yJ3;
		SJ3 = sJ3;
		JM3 = jM3;
		QF3 = qF3;
		YJ = yJ;
		SJ = sJ;
		JM = jM;
		QF = qF;
	}
	public String getYear() {
		return year;
	}
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public void setYear(String year) {
		this.year = year;
	}
	public BigDecimal getYJ1() {
		return YJ1;
	}
	public void setYJ1(BigDecimal yJ1) {
		YJ1 = yJ1;
	}
	public BigDecimal getSJ1() {
		return SJ1;
	}
	public void setSJ1(BigDecimal sJ1) {
		SJ1 = sJ1;
	}
	public BigDecimal getJM1() {
		return JM1;
	}
	public void setJM1(BigDecimal jM1) {
		JM1 = jM1;
	}
	public BigDecimal getQF1() {
		return QF1;
	}
	public void setQF1(BigDecimal qF1) {
		QF1 = qF1;
	}
	public BigDecimal getYJ2() {
		return YJ2;
	}
	public void setYJ2(BigDecimal yJ2) {
		YJ2 = yJ2;
	}
	public BigDecimal getSJ2() {
		return SJ2;
	}
	public void setSJ2(BigDecimal sJ2) {
		SJ2 = sJ2;
	}
	public BigDecimal getJM2() {
		return JM2;
	}
	public void setJM2(BigDecimal jM2) {
		JM2 = jM2;
	}
	public BigDecimal getQF2() {
		return QF2;
	}
	public void setQF2(BigDecimal qF2) {
		QF2 = qF2;
	}
	public BigDecimal getYJ3() {
		return YJ3;
	}
	public void setYJ3(BigDecimal yJ3) {
		YJ3 = yJ3;
	}
	public BigDecimal getSJ3() {
		return SJ3;
	}
	public void setSJ3(BigDecimal sJ3) {
		SJ3 = sJ3;
	}
	public BigDecimal getJM3() {
		return JM3;
	}
	public void setJM3(BigDecimal jM3) {
		JM3 = jM3;
	}
	public BigDecimal getQF3() {
		return QF3;
	}
	public void setQF3(BigDecimal qF3) {
		QF3 = qF3;
	}
	public BigDecimal getYJ() {
		return YJ;
	}
	public void setYJ(BigDecimal yJ) {
		YJ = yJ;
	}
	public BigDecimal getSJ() {
		return SJ;
	}
	public void setSJ(BigDecimal sJ) {
		SJ = sJ;
	}
	public BigDecimal getJM() {
		return JM;
	}
	public void setJM(BigDecimal jM) {
		JM = jM;
	}
	public BigDecimal getQF() {
		return QF;
	}
	public void setQF(BigDecimal qF) {
		QF = qF;
	}
	
}
