package com.uws.home.model;
import java.io.Serializable;
import java.util.List;

/**
 * 评论传输对象
 * @author hejin
 *
 */
public class MhMessageDTO implements Serializable{

	
	private static final long serialVersionUID = -4175717031704512525L;
	
	
	private String mhOwner;//被评论人id
	private String mhSender;//评论者id
	private String mhContent;//评论内容
	private String mhParentId;//被回复的评论id
	private String id;//评论id
	private int mhZan;//被赞的数量
	private String createTime;//评论时间
	private List<MhMessageDTO> receive;//被赞的数量
	
	
	public String getMhOwner() {
		return mhOwner;
	}
	public void setMhOwner(String mhOwner) {
		this.mhOwner = mhOwner;
	}
	public String getMhSender() {
		return mhSender;
	}
	public void setMhSender(String mhSender) {
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getMhZan() {
		return mhZan;
	}
	public void setMhZan(int mhZan) {
		this.mhZan = mhZan;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public List<MhMessageDTO> getReceive() {
		return receive;
	}
	public void setReceive(List<MhMessageDTO> receive) {
		this.receive = receive;
	}
	
	
	
     
}
