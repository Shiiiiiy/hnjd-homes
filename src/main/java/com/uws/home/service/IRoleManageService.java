package com.uws.home.service;

import java.util.List;
import java.util.Map;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoles;
/**
 * @ClassName    IRoleManageService
 * @Description  门户角色信息管理service
 * @author       何进
 * @date         2016-09-05下午20:31:22
 */
public interface IRoleManageService extends IBaseService{
      

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
	 * 保存角色信息
	 * @param mhRole	要保存的角色信息
	 * @return	void
	 */
	public void saveMhRole(MhRoles mhRole);
	
	/**
	 * 保存角色信息
	 * @param mhRoleId	要删除的角色id
	 * @return	void
	 */
	public void delMhRole(String mhRoleId);
    
	/**
	 * 给角色分配数据权限
	 * @param collegeList	学院列表（有  "","defualt_college",学院id列表以逗号分隔  这三种情况）
	 * @param roleId	            角色id
	 * @return	void
	 */
	public void allotDataPermisson(String collegeList, String roleId);
    
	/**
	 * 获取用户菜单权限
	 * @param roleId	            角色id
	 * @return	List<MhMenu>   菜单列表
	 */
	public List<MhMenu> getUserMenuPermisson(String userId);
	
	
	/**
	 * 获取角色列表
	 * @return	List<MhRoles>  角色列表
	 */
	public List<MhRoles> getAllMhRolesList();
	
	
	/**
	 * 根据编码查询角色信息
	 * @param mhRoleCode	 角色编码
	 * @return	MhRoles  角色信息实体
	 */
	public MhRoles getMhRoleByCode(String mhRoleCode);
    
	/**
	 * 根据用户id查询对应权限
	 * @param userId	用户id
	 * @return	 Map<String, String>  数据权限集合
	 */
	public Map<String, String> getUserDataPermisson(String userId);
    
	/**
	 * 根据用户id查询 用户可展示菜单
	 * @param userId	用户id
	 * @return	 Map<String, List<MhMenu>>  用户可展示菜单，用户自定义菜单配置可展示菜单
	 */
	public Map<String, List<MhMenu>> getUserVisiableMenu(String userId);
	
	
	/**
	 * 根据角色名称查询角色信息
	 * @param mhRoleName	 角色名称
	 * @return	List<MhRoles>  角色信息实体列表
	 */
	public List<MhRoles> getMhRoleByName(String mhRoleName);
	
}
