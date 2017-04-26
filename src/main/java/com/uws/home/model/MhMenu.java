package com.uws.home.model;

import com.uws.core.base.BaseModel;
/**
 * 门户菜单信息model
 * @author hejin
 *
 */
public class MhMenu extends BaseModel implements Comparable<MhMenu>{

	private static final long serialVersionUID = 3371230669568535307L;
	
	private String mhMenuCode;//菜单编码
	private String mhMenuName;//菜单名称
	private String mhMenuUrl;//菜单路径
	private Integer mhMenuLevel;//菜单级别
	private Integer mhMenuOrder;//菜单顺序
	private String mhMenuImage;//菜单图片
	private MhDic status;//启用状态
	private MhDic deleteStatus;//逻辑删除
	private String id;//id
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMhMenuCode() {
		return mhMenuCode;
	}
	public void setMhMenuCode(String mhMenuCode) {
		this.mhMenuCode = mhMenuCode;
	}
	public String getMhMenuName() {
		return mhMenuName;
	}
	public void setMhMenuName(String mhMenuName) {
		this.mhMenuName = mhMenuName;
	}
	public String getMhMenuUrl() {
		return mhMenuUrl;
	}
	public void setMhMenuUrl(String mhMenuUrl) {
		this.mhMenuUrl = mhMenuUrl;
	}
	public Integer getMhMenuLevel() {
		return mhMenuLevel;
	}
	public void setMhMenuLevel(Integer mhMenuLevel) {
		this.mhMenuLevel = mhMenuLevel;
	}
	public Integer getMhMenuOrder() {
		return mhMenuOrder;
	}
	public void setMhMenuOrder(Integer mhMenuOrder) {
		this.mhMenuOrder = mhMenuOrder;
	}
	public String getMhMenuImage() {
		return mhMenuImage;
	}
	public void setMhMenuImage(String mhMenuImage) {
		this.mhMenuImage = mhMenuImage;
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
	
	//排序用-----start
	public int compareTo(MhMenu o) {
	        if(mhMenuOrder!=o.getMhMenuOrder()){
	            return mhMenuOrder-o.getMhMenuOrder();
	        }else if(!id.equals(o.getId())){
	            return id.compareTo(o.getId());
	        }else{
	        	return 1;
	         
	        }
	    }
	 
	 @Override
	 public boolean equals(Object obj) {
	        if(obj instanceof MhMenu){
	        	MhMenu stu=(MhMenu)obj;
	            if((mhMenuOrder==stu.getMhMenuOrder())&&(id.equals(stu.getId()))){
	                return true;
	            }else
	                return true;
	        }else{
	            return false;
	        }
	    }
	//排序用-----end
	
     
}
