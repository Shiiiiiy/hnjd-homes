package com.uws.home.model;

import com.uws.core.base.BaseModel;
/**
 * 门户字典表model
 * @author hejin
 *
 */
public class MhDic extends BaseModel{

	private static final long serialVersionUID = -7780930104701051610L;
    
	
	private String mhCode;//字典编码
	private String mhName;//字典名称
	private String mhParentId;//字典父id
	private int status;//启用状态
	private int deleteStatus;//逻辑删除
	
	
	public String getMhCode() {
		return mhCode;
	}
	public void setMhCode(String mhCode) {
		this.mhCode = mhCode;
	}
	public String getMhName() {
		return mhName;
	}
	public void setMhName(String mhName) {
		this.mhName = mhName;
	}
	public String getMhParentId() {
		return mhParentId;
	}
	public void setMhParentId(String mhParentId) {
		this.mhParentId = mhParentId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getDeleteStatus() {
		return deleteStatus;
	}
	public void setDeleteStatus(int deleteStatus) {
		this.deleteStatus = deleteStatus;
	}
	
}
