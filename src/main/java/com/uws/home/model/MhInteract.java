package com.uws.home.model;

import com.uws.core.base.BaseModel;
import com.uws.user.model.User;
/**
 * 老师和学生互动model
 * @author hejin
 *
 */
public class MhInteract extends BaseModel{

	private static final long serialVersionUID = -7528354470138104384L;

	
	private User mhUserid;//用户id
	private int mhFlower;//收到的鲜花数量
	private int mhEgg;//收到的鸡蛋数量
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	
	
	public User getMhUserid() {
		return mhUserid;
	}
	public void setMhUserid(User mhUserid) {
		this.mhUserid = mhUserid;
	}
	public int getMhFlower() {
		return mhFlower;
	}
	public void setMhFlower(int mhFlower) {
		this.mhFlower = mhFlower;
	}
	public int getMhEgg() {
		return mhEgg;
	}
	public void setMhEgg(int mhEgg) {
		this.mhEgg = mhEgg;
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
