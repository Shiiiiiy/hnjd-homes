package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoleUser;
import com.uws.user.model.Org;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;
/**
 * @ClassName    IRoleUserManageService
 * @Description  门户用户与角色关系管理service
 * @author       何进
 * @date         2016-09-05下午17:14:22
 */
public interface IRoleUserManageService extends IBaseService{
      
	/**
	 * 新增用户与角色关系
	 * @param mhRoleUser	 用户与角色关系信息
	 * @return	void
	 */
	public void saveMhRoleUser(MhRoleUser mhRoleUser);
	
	

	/**
	 * 根据用户id查询用户信息
	 * @param userId	 用户id
	 * @return	User    用户信息
	 */
	public User getUserById(String userId);

	
	/**
	 * 查询一页用户信息
	 * @param pageNo	 当前页
	 * @param name      用户名
	 * @return	Page    用户信息分页数据
	 */
	public Page getUserList(String name,int pageNo);

	/**
	 * 查询学院列表
	 * @return	List<Org>   学院列表
	 */
	public List<Org> getAllOrg();
	
	/**
	 * 给角色分配用户
	 * @param   userList    用户id列表（以逗号分隔）
	 * @param   roleId      角色id
	 * @param   pageNo      当前页
	 * @return	void
	 */
	public void allotUser(String userList,String roleId,int pageNo);


	/**
	 * 查询当前角色分配给了哪些用户
	 * @param   userId    用户id
	 * @param   roleId      角色id
	 * @return	List<MhRoleUser>   用户与角色关系列表
	 */
	public List<MhRoleUser> getMhRoleUserByUserIdOrRoleId(String userId, String roleId);
	

	
	/**
	 * 查询用户登录信息
	 * String userId    用户id
	 * @param	UserLogin   用户登录信息
	 */
	public UserLogin getLoginUser(String userId);


	/**
	 * 修改用户密码
	 * String userId    用户id
	 */
	public void updateUserPassword(String userId);
}
