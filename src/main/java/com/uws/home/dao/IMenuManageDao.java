package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;

/**
 * 门户菜单管理接口
 * @author hejin
 *
 */
public interface IMenuManageDao extends IBaseDao{
    
	/**
	 * 获取菜单列表
	 * @param   mhDic  未删除的
	 * @return	List<MhMenu>  菜单列表
	 */
	public List<MhMenu> getAllMenuList(MhDic mhDic);

	/**
	 * 获取菜单列表
	 * @param   mhDic  未删除的
	 * @param   mhMenuId  菜单id
	 * @return	MhMenu  菜单列表
	 */
	public MhMenu getOneMenu(MhDic mhDic, String mhMenuId);
	
	
	
}
