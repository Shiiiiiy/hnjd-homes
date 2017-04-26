package com.uws.home.model;

import com.uws.core.base.BaseModel;
import com.uws.user.model.User;
/**
 * 用户菜单自定义配置信息model
 * @author hejin
 *
 */
public class MhConfig extends BaseModel{

	private static final long serialVersionUID = -7215195856501644680L;
	
	
	private User mhUserid;//用户id
	private String mhMenus;//菜单列表，各菜单id之间以逗号分隔
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	
	
	public User getMhUserid() {
		return mhUserid;
	}
	public void setMhUserid(User mhUserid) {
		this.mhUserid = mhUserid;
	}
	public String getMhMenus() {
		return mhMenus;
	}
	public void setMhMenus(String mhMenus) {
		this.mhMenus = mhMenus;
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
