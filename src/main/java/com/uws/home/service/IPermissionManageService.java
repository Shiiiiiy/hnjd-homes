package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoleUser;
import com.uws.user.model.Org;
import com.uws.user.model.User;
/**
 * @ClassName    IPermissionManageService
 * @Description  门户角色与菜单关系管理service
 * @author       hejin
 * @date         2016-09-05下午21:54:22
 */
public interface IPermissionManageService extends IBaseService{
      
	/**
	 * 新增角色与菜单关系
	 * @param mhPermission	 角色与菜单关系信息
	 * @return	void
	 */
	public void saveMhPermission(MhPermission mhPermission);
	
	
	/**
	 * 给角色分配菜单
	 * @param roleId	角色id
	 * @param mhMenuList 菜单id列表（以逗号分隔）
	 * @return	void
	 */
    public void allotMhMenu(String mhMenuList,String roleId);
    
    /**
	 * 查询当前角色的菜单列表
	 * @param roleId	角色id
	 * @return	List<MhPermission>    角色与菜单关系列表
	 */
    public List<MhPermission> getMhPermissionByRoleId(String roleId);
	
	
}
