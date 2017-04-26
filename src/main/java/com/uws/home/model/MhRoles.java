package com.uws.home.model;

import com.uws.core.base.BaseModel;
/**
 * 门户角色表model
 * @author hejin
 *
 */
public class MhRoles extends BaseModel{

	private static final long serialVersionUID = 8971510600831510157L;

	private String mhRoleCode;//角色编码
	private String mhRoleName;//角色名称
	private MhDic mhRoleType;//角色类型
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	private String colleges;//数据权限——学院列表
	
	
	public String getMhRoleCode() {
		return mhRoleCode;
	}
	public void setMhRoleCode(String mhRoleCode) {
		this.mhRoleCode = mhRoleCode;
	}
	public String getMhRoleName() {
		return mhRoleName;
	}
	public void setMhRoleName(String mhRoleName) {
		this.mhRoleName = mhRoleName;
	}
	public MhDic getMhRoleType() {
		return mhRoleType;
	}
	public void setMhRoleType(MhDic mhRoleType) {
		this.mhRoleType = mhRoleType;
	}
	public MhDic getStatus() {
		return status;
	}
	public void setStatus(MhDic status) {
		this.status = status;
	}
	public MhDic getDeleteStatus() {
		return deleteStatus;
	}
	public void setDeleteStatus(MhDic deleteStatus) {
		this.deleteStatus = deleteStatus;
	}
	public String getColleges() {
		return colleges;
	}
	public void setColleges(String colleges) {
		this.colleges = colleges;
	}
	
	
	
	
}
