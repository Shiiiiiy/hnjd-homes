package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoles;

/**
 * 门户角色管理接口
 * @author hejin
 *
 */
public interface IRoleManageDao extends IBaseDao{
    
	/**
	 * 根据条件查询角色列表
	 * @param pageNo	  当前页
	 * @param mhRole	   角色查询条件
	 * @return	Page   角色列表查询分页对象
	 */
	public Page getMhRoleList(int pageNo,MhRoles mhRole);
	
	/**
	 * 根据id查询角色信息
	 * @param mhRoleId	    id
	 * @return	MhDic  角色信息实体
	 */
	public MhRoles getMhRoleById(String mhRoleId);
	
	/**
	 * 根据编码查询角色信息
	 * @param mhRoleCode	 角色编码
	 * @return	MhRoles  角色信息实体
	 */
	public MhRoles getMhRoleByCode(String mhRoleCode);
	
	
	/**
	 * 根据角色名称查询角色信息
	 * @param mhRoleName	 角色名称
	 * @return	List<MhRoles>  角色信息实体列表
	 */
	public List<MhRoles> getMhRoleByName(String mhRoleName);
	
	
	/**
	 * 保存角色信息
	 * @param mhRole	要保存的角色信息
	 * @return	void
	 */
	public void saveMhRole(MhRoles mhRole);
    
	/**
	 * 获取角色列表
	 * @param mhDic	字典未删除的
	 * @return	List<MhRoles>  角色列表
	 */
	public List<MhRoles> getAllMhRolesList(MhDic mhDic);
	
}
