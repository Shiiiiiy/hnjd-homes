package com.uws.home.model;

import com.uws.core.base.BaseModel;
import com.uws.user.model.User;

/**
 * 用户与角色关系model
 * @author hejin
 *
 */
public class MhRoleUser extends BaseModel{

	private static final long serialVersionUID = -7006641776166447202L;
      
	
	private User mhUserid;//用户id
	private MhRoles mhRoleId;//角色id
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	
	public User getMhUserid() {
		return mhUserid;
	}
	public void setMhUserid(User mhUserid) {
		this.mhUserid = mhUserid;
	}
	public MhRoles getMhRoleId() {
		return mhRoleId;
	}
	public void setMhRoleId(MhRoles mhRoleId) {
		this.mhRoleId = mhRoleId;
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
