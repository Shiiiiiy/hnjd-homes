package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoleUser;

/**
 * 门户角色与菜单关系管理接口
 * @author hejin
 *
 */
public interface IPermissionManageDao extends IBaseDao{
    
	/**
	 * 新增角色与菜单关系
	 * @param mhPermission	 角色与菜单关系信息
	 * @return	void
	 */
	public void saveMhPermission(MhPermission mhPermission);
	
	/**
	 * 根据菜单id或角色id查询角色与菜单关系信息
	 * @param userId	   用户id
	 * @param mhDic   未删除的
	 * @param roleId	 角色id
	 * @return	List<MhPermission>  角色与菜单信息列表
	 */
	public List<MhPermission> getMhPermissionByUserIdOrRoleId(String menuId,String roleId,MhDic mhDic);
	
	/**
	 * 根据角色id批量修改角色与菜单关系信息
	 * @param roleId	 角色id
	 * @return	void
	 */
	public void updateMhPermissionByRoleId(String roleId,MhDic mhDic);
	
}
