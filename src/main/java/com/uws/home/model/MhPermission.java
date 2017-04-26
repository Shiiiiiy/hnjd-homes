package com.uws.home.model;

import com.uws.core.base.BaseModel;

/**
 * 门户权限model
 * @author hejin
 *
 */
public class MhPermission extends BaseModel{

	private static final long serialVersionUID = -1660739473109984020L;
	
	private MhRoles mhRoleid;//角色id
	private MhMenu mhMenuId;//菜单id
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	
	public MhRoles getMhRoleid() {
		return mhRoleid;
	}
	public void setMhRoleid(MhRoles mhRoleid) {
		this.mhRoleid = mhRoleid;
	}
	public MhMenu getMhMenuId() {
		return mhMenuId;
	}
	public void setMhMenuId(MhMenu mhMenuId) {
		this.mhMenuId = mhMenuId;
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

}
