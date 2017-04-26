package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;

/**
 * 用户自定义菜单配置管理接口
 * @author hejin
 *
 */
public interface IConfigManageDao extends IBaseDao{
    
	/**
	 * 根据用户id查询用户自定义菜单配置信息
	 * @param userId	   用户id
	 * @return	MhConfig  用户自定义菜单配置信息
	 */
	public MhConfig getMhConfigByUserId(String userId);
	
	/**
	 * 保存用户自定义菜单配置信息
	 * @param mhConfig	    用户自定义菜单配置信息
	 * @return	void
	 */
	public void saveMhConfig(MhConfig mhConfig);
	
	
}
