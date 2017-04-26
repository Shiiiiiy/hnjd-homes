package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
/**
 * @ClassName    IMenuManageService
 * @Description  门户菜单管理service
 * @author       何进
 * @date         2016-09-02下午11:14:22
 */
public interface IMenuManageService extends IBaseService{
      

	/**
	 * 获取菜单列表
	 * mhDic  未删除的
	 * @return	List<MhMenu>  菜单列表
	 */
	public List<MhMenu> getAllMenuList(MhDic mhDic);
	

}
