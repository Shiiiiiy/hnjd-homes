package com.uws.home.model;

import java.util.List;

import com.uws.core.base.BaseModel;
import com.uws.user.model.User;
/**
 * 评论model
 * @author hejin
 *
 */
public class MhMessage extends BaseModel{

	private static final long serialVersionUID = -6717325764432933022L;

	private User mhOwner;//被评论人id
	private User mhSender;//评论者id
	private String mhContent;//评论内容
	private String mhParentId;//被回复的评论id
	private MhDic mhIsread;//是否已读
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	private int mhZan;//被赞的数量
	private List<MhMessage> receive;//被赞的数量
	

	public List<MhMessage> getReceive() {
		return receive;
	}
	public void setReceive(List<MhMessage> receive) {
		this.receive = receive;
	}
	public int getMhZan() {
		return mhZan;
	}
	public void setMhZan(int mhZan) {
		this.mhZan = mhZan;
	}
	public User getMhOwner() {
		return mhOwner;
	}
	public void setMhOwner(User mhOwner) {
		this.mhOwner = mhOwner;
	}
	public User getMhSender() {
		return mhSender;
	}
	public void setMhSender(User mhSender) {
		this.mhSender = mhSender;
	}
	public String getMhContent() {
		return mhContent;
	}
	public void setMhContent(String mhContent) {
		this.mhContent = mhContent;
	}
	public String getMhParentId() {
		return mhParentId;
	}
	public void setMhParentId(String mhParentId) {
		this.mhParentId = mhParentId;
	}
	public MhDic getMhIsread() {
		return mhIsread;
	}
	public void setMhIsread(MhDic mhIsread) {
		this.mhIsread = mhIsread;
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
