package com.uws.home.model;
import java.util.List;

import com.uws.core.base.BaseModel;
/**
 * 门户用户信息数据包 教师
 */
public class MhTeacherUser extends BaseModel{
	private static final long serialVersionUID = 3882676175877715389L;
	/**用户 的ID*/
	private String USER_ID;
	/**用户 姓名*/
	private String TEACHER_NAME;
	/**所在 机构ID*/
	private List<String> ORG_ID;
	/**机构 名称*/
	private List<String> ORG_NAME;
	/**当前学年*/
	private String nowYear;
	/** 是否有查看所有院系的权限  */
	private String isFullPower;

	public String getNowYear() {
		return nowYear;
	}
	public void setNowYear(String nowYear) {
		this.nowYear = nowYear;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getTEACHER_NAME() {
		return TEACHER_NAME;
	}
	public void setTEACHER_NAME(String tEACHER_NAME) {
		TEACHER_NAME = tEACHER_NAME;
	}
	public List<String> getORG_ID() {
		return ORG_ID;
	}
	public void setORG_ID(List<String> oRG_ID) {
		ORG_ID = oRG_ID;
	}
	public List<String> getORG_NAME() {
		return ORG_NAME;
	}
	public void setORG_NAME(List<String> oRG_NAME) {
		ORG_NAME = oRG_NAME;
	}
	public String getIsFullPower() {
		return isFullPower;
	}
	public void setIsFullPower(String isFullPower) {
		this.isFullPower = isFullPower;
	}
}
