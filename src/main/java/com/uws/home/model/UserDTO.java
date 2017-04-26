package com.uws.home.model;

import java.io.Serializable;
/**
 * 用户传输对象
 * @author hejin
 *
 */
public class UserDTO implements Serializable{

	private static final long serialVersionUID = 6229918443968381310L;
	
	private String name;//用户名
	private String gender;//用户性别
	private String certType;//用户证件类型
	private String certNum;//用户证件号码
	private String id;//用户id
	private String address;//用户地址
	
	
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCertType() {
		return certType;
	}
	public void setCertType(String certType) {
		this.certType = certType;
	}
	public String getCertNum() {
		return certNum;
	}
	public void setCertNum(String certNum) {
		this.certNum = certNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}
