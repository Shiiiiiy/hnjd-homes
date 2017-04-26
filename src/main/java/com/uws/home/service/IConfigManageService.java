package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * @ClassName    IConfigManageService
 * @Description  门户自定义菜单配置信息管理service
 * @author       何进
 * @date         2016-09-02下午12:24:22
 */
public interface IConfigManageService extends IBaseService{
      

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
