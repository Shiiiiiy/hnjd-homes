package com.uws.home.model;

import java.io.Serializable;
/**
 * 新闻传输对象
 * @author hejin
 *
 */
public class MhNewsDTO implements Serializable{

	
	private static final long serialVersionUID = -7096410778438916389L;
	
	private String mhPublisher;//新闻发布者或单位
	private String mhNewsTypeName;//新闻类型
	private String mhNewsTypeId;//新闻类型编码(注意不是id,临时新增变量，名称不宜变动，将就着用)
	private String mhNewsTypeCode;//新闻类型id(注意不是code,临时新增变量，名称不宜变动，将就着用)
	private String mhNewsTitle;//新闻标题
	private String mhNewsContent;//新闻内容
	private String newTime;//json传输用
	private String status;//是否已发布
	private String id;
	
	
	
	
	public String getMhNewsTypeCode() {
		return mhNewsTypeCode;
	}
	public void setMhNewsTypeCode(String mhNewsTypeCode) {
		this.mhNewsTypeCode = mhNewsTypeCode;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMhPublisher() {
		return mhPublisher;
	}
	public void setMhPublisher(String mhPublisher) {
		this.mhPublisher = mhPublisher;
	}
	public String getMhNewsTypeName() {
		return mhNewsTypeName;
	}
	public void setMhNewsTypeName(String mhNewsTypeName) {
		this.mhNewsTypeName = mhNewsTypeName;
	}
	public String getMhNewsTypeId() {
		return mhNewsTypeId;
	}
	public void setMhNewsTypeId(String mhNewsTypeId) {
		this.mhNewsTypeId = mhNewsTypeId;
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
	public String getNewTime() {
		return newTime;
	}
	public void setNewTime(String newTime) {
		this.newTime = newTime;
	}
	

}
