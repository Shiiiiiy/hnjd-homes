package com.uws.home.model;

import com.uws.core.base.BaseModel;
import com.uws.user.model.User;
/**
 * 门户新闻model
 * @author hejin
 *
 */
public class MhNews extends BaseModel{

	private static final long serialVersionUID = 8061690597237641423L;

	private User mhCreator;//创建者
	private MhDic mhNewsType;//新闻类型
	private String mhNewsTitle;//新闻标题
	private String mhNewsContent;//新闻内容
	private String mhPublisher;//新闻发布者或单位
	private MhDic status;//是否已发布
	private MhDic deleteStatus;//逻辑删除
	private String newTime;//json传输用
	
	
	public String getNewTime() {
		return newTime;
	}
	public void setNewTime(String newTime) {
		this.newTime = newTime;
	}
	public User getMhCreator() {
		return mhCreator;
	}
	public void setMhCreator(User mhCreator) {
		this.mhCreator = mhCreator;
	}
	public MhDic getMhNewsType() {
		return mhNewsType;
	}
	public void setMhNewsType(MhDic mhNewsType) {
		this.mhNewsType = mhNewsType;
	}
	public String getMhNewsTitle() {
		return mhNewsTitle;
	}
	public void setMhNewsTitle(String mhNewsTitle) {
		this.mhNewsTitle = mhNewsTitle;
	}
	public String getMhNewsContent() {
		return mhNewsContent;
	}
	public void setMhNewsContent(String mhNewsContent) {
		this.mhNewsContent = mhNewsContent;
	}
	public String getMhPublisher() {
		return mhPublisher;
	}
	public void setMhPublisher(String mhPublisher) {
		this.mhPublisher = mhPublisher;
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
