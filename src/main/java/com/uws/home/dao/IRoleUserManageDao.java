package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoleUser;
import com.uws.user.model.Org;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;

/**
 * 门户用户与角色关系管理接口
 * @author hejin
 *
 */
public interface IRoleUserManageDao extends IBaseDao{
    
	/**
	 * 新增用户与角色关系
	 * @param mhRoleUser	 用户与角色关系信息
	 * @return	void
	 */
	public void saveMhRoleUser(MhRoleUser mhRoleUser);
	
	/**
	 * 根据用户id或角色id查询用户与角色关系信息
	 * @param userId	   用户id
	 * @param mhDic   未删除的
	 * @param roleId	 角色id
	 * @return	List<MhRoleUser>  用户与角色信息列表
	 */
	public List<MhRoleUser> getMhRoleUserByUserIdOrRoleId(String userId,String roleId,MhDic mhDic);
	
	/**
	 * 根据角色id批量修改用户与角色关系信息
	 * @param roleId	 角色id
	 * @return	void
	 */
	public void updateMhRoleUserByRoleId(String roleId,MhDic mhDic);

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
	 * 查询所有用户列表
	 * @return	List<User>   用户列表
	 */
	public List<User> getAllUser();

	/**
	 * 查询用户登录信息
	 * String userId    用户id
	 * @param	UserLogin   用户登录信息
	 */
	public UserLogin getLoginUser(String userId);
    
	/**
	 * 修改用户密码
	 * @param	userLoginId   用户id
	 * @param   password 用户修改后的密码
	 * @param   salt 密钥
	 */
	public void updatePassword(String userLoginId, String password,String salt);
	
}
