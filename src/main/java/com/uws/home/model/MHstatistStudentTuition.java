package com.uws.home.model;

import com.uws.core.base.BaseModel;
/**
 *   以学院为单位  饼图走财务  建立实体类 全部 String
   List [院系名称,总人数,完全缴,未缴,部分缴,缴费状态]
	 以学院为单位  柱状走学工
	[生源地贷人数,校园地贷人数,缓缴人数,奖学金人数,助学金人数,免缴人数]
 * */
public class MHstatistStudentTuition extends BaseModel{
	private static final long serialVersionUID = -4171115755557560381L;
	/**院系名称*/
	public String XYMC;
	//--------------------------------------/
	/**总人数*/
	public int ZRS;
	/**总-缴费状态  */
	public String JFZT;
	//--------------------------------------/
	/**总-完全缴人数*/
	public int WQJF;	
	/**总-未缴人数*/
	public int WJF;
	/**总-部分缴人数*/
	public int BFJF;
	//--------------------------------------/
	/**学费-完全缴人数*/
	public int WQJF1;	
	/**学费-未缴人数*/
	public int WJF1;
	/**学费-部分缴人数*/
	public int BFJF1;
	//--------------------------------------/
	/**教材费-完全缴人数*/
	public int WQJF2;	
	/**教材费-未缴人数*/
	public int WJF2;
	/**教材费-部分缴人数*/
	public int BFJF2;
	//--------------------------------------/
	/**住宿费-完全缴人数*/
	public int WQJF3;	
	/**住宿费-未缴人数*/
	public int WJF3;
	/**住宿费-部分缴人数*/
	public int BFJF3;
	//-旧字段----------------------------------/
	/**生源地贷人数*/
	public int SYDDK;
	/**校园地贷人数*/
	public int XYDDK;
	/**缓缴人数*/
	public int HJRS;
	/**奖学金人数*/
	public int JXJRS;
	/**助学金人数*/
	public int ZXJRS;
	/**免缴人数*/
	public int MJRS;
	/**计算缴费状态*/
	public void toaddJFZT(){
		this.JFZT="部分缴费";//无人缴费  全部缴清  “”表示 其他
		if(ZRS!=0 && (WJF==ZRS)){
			this.JFZT="无人缴费";
		}
		if(ZRS==WQJF && WJF==0 && BFJF==0){
			this.JFZT="全部缴清";
		}
	}
	//以下是get set//
	public String getXYMC() {
		return XYMC;
	}
	public void setXYMC(String xYMC) {
		XYMC = xYMC;
	}
	public int getZRS() {
		return ZRS;
	}
	public void setZRS(int zRS) {
		ZRS = zRS;
	}
	public int getWQJF() {
		return WQJF;
	}
	public void setWQJF(int wQJF) {
		WQJF = wQJF;
	}
	public int getWJF() {
		return WJF;
	}
	public void setWJF(int wJF) {
		WJF = wJF;
	}
	public int getBFJF() {
		return BFJF;
	}
	public void setBFJF(int bFJF) {
		BFJF = bFJF;
	}
	public String getJFZT() {
		return JFZT;
	}
	public void setJFZT(String jFZT) {
		JFZT = jFZT;
	}
	public int getSYDDK() {
		return SYDDK;
	}
	public void setSYDDK(int sYDDK) {
		SYDDK = sYDDK;
	}
	public int getXYDDK() {
		return XYDDK;
	}
	public void setXYDDK(int xYDDK) {
		XYDDK = xYDDK;
	}
	public int getHJRS() {
		return HJRS;
	}
	public void setHJRS(int hJRS) {
		HJRS = hJRS;
	}
	public int getJXJRS() {
		return JXJRS;
	}
	public void setJXJRS(int jXJRS) {
		JXJRS = jXJRS;
	}
	public int getZXJRS() {
		return ZXJRS;
	}
	public void setZXJRS(int zXJRS) {
		ZXJRS = zXJRS;
	}
	public int getMJRS() {
		return MJRS;
	}
	public void setMJRS(int mJRS) {
		MJRS = mJRS;
	}
	public int getWQJF1() {
		return WQJF1;
	}
	public void setWQJF1(int wQJF1) {
		WQJF1 = wQJF1;
	}
	public int getWJF1() {
		return WJF1;
	}
	public void setWJF1(int wJF1) {
		WJF1 = wJF1;
	}
	public int getBFJF1() {
		return BFJF1;
	}
	public void setBFJF1(int bFJF1) {
		BFJF1 = bFJF1;
	}
	public int getWQJF2() {
		return WQJF2;
	}
	public void setWQJF2(int wQJF2) {
		WQJF2 = wQJF2;
	}
	public int getWJF2() {
		return WJF2;
	}
	public void setWJF2(int wJF2) {
		WJF2 = wJF2;
	}
	public int getBFJF2() {
		return BFJF2;
	}
	public void setBFJF2(int bFJF2) {
		BFJF2 = bFJF2;
	}
	public int getWQJF3() {
		return WQJF3;
	}
	public void setWQJF3(int wQJF3) {
		WQJF3 = wQJF3;
	}
	public int getWJF3() {
		return WJF3;
	}
	public void setWJF3(int wJF3) {
		WJF3 = wJF3;
	}
	public int getBFJF3() {
		return BFJF3;
	}
	public void setBFJF3(int bFJF3) {
		BFJF3 = bFJF3;
	}
}
