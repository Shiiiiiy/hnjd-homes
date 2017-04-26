package com.uws.home.dao.impl;


import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;

import javax.annotation.Resource;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.core.util.HqlEscapeUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.dao.IRoleUserManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoleUser;
import com.uws.sys.model.Dic;
import com.uws.user.model.Org;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;
/**
 * 门户用户与角色关系管理实现类
 * @author hejin
 *
 */
@Repository("RoleUserManageDaoImpl")
public class RoleUserManageDaoImpl extends BaseDaoImpl implements IRoleUserManageDao{
	
	//BDP平台 
	@Resource(name = "bdpJdbcTemplate")
	private JdbcTemplate bdpJdbcTemplate ;//学工库 已经在门户  必要时修改为学工库

	@Override
	public void saveMhRoleUser(MhRoleUser mhRoleUser){
		this.save(mhRoleUser);
	}
	
	@Override
	public List<MhRoleUser> getMhRoleUserByUserIdOrRoleId(String userId,String roleId,MhDic mhDic){
		
		StringBuffer hql=new StringBuffer("select ru from MhRoleUser ru where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(userId)){
			hql.append(" and ru.mhUserid.id = ?  ");
			values.add(userId);
			
		}
		
		if(DataUtil.isNotNull(roleId)){
			hql.append(" and ru.mhRoleId.id = ?  ");
			values.add(roleId);
			
		}
		
		if(DataUtil.isNotNull(mhDic)){
			hql.append(" and ru.deleteStatus = ?  ");
			values.add(mhDic);
			
		}
		
		return (List<MhRoleUser>)this.query(hql.toString(), values.toArray());
		
	 }
	
	
	
	
	@Override
	public void updateMhRoleUserByRoleId(String roleId,MhDic mhDic){
		StringBuffer hql=new StringBuffer("update MhRoleUser mss  set mss.deleteStatus=? where mss.mhRoleId.id=? ");
		List<Object> values=new ArrayList();
		
		values.add(mhDic);
		values.add(roleId);
		this.executeHql(hql.toString(), values.toArray());
		
	}
	
	@Override
	public User getUserById(String userId){
		
		return (User)this.get(User.class, userId);
	}
	
	
	public Dic getNormalDic(String code,String dicCategoryId){
		String hql="select dic from Dic  dic where dic.code=? and dic.status='1' and dic.dicCategory.id=?  ";
	
	    return (Dic)this.queryUnique(hql.toString(), new Object[]{code,dicCategoryId});
	}
	
	@Override
	public Page getUserList(String names,int pageNo){
		StringBuffer hql=new StringBuffer("select uss from User uss  where 1=1 and uss.deleteStatus=? and uss.userType=? ");
		List<Object> values=new ArrayList();
		values.add(getNormalDic("NORMAL","4028900f40be6ba90140be95d9400000"));
		values.add(getNormalDic("TEACHER","402894e644f7d2db0144f7d4e26a0002"));
		
		
		if(DataUtil.isNotNull(names)){
			
		    hql.append(" and uss.name like ?  ");
		    values.add("%"+names+"%");
			
		}
		
		hql.append(" ORDER BY NLSSORT(uss.name, 'NLS_SORT=SCHINESE_PINYIN_M')  ");
		if (values.size() == 0){
			return this.pagedQuery(hql.toString(), pageNo, 10);
		}else{
			return this.pagedQuery(hql.toString(),pageNo, 10,values.toArray() );
		} 
	}
	
	@Override
	public List<User> getAllUser(){
		String hql="select us from User us  where us.deleteStatus=? and us.userType=? order by createTime desc ";
		List<Object> values=new ArrayList();
		values.add(getNormalDic("NORMAL","4028900f40be6ba90140be95d9400000"));
		values.add(getNormalDic("TEACHER","402894e644f7d2db0144f7d4e26a0002"));
		return this.query(hql.toString(), values.toArray()); 
	}
	
	
	@Override
	public List<Org> getAllOrg(){
		String hql="select us from Org us  where us.orgType=? and us.status=? order by updateTime desc ";
		List<Object> values=new ArrayList();
		values.add(getNormalDic("INSTITUTE","402894e64de58606014de59bfc260003")); 
		values.add(getNormalDic("ENABLE","297eaf3e409e862601409eddecb60001"));  
		return this.query(hql.toString(), values.toArray());
	}
	
	@Override
	public UserLogin getLoginUser(String userId){
		String hql="select us from UserLogin us  where 1=1 and us.user.id=? ";
		return (UserLogin)this.queryUnique(hql.toString(), new Object[]{userId});
	}
	
	
	@Override
	public void updatePassword(String userLoginId,String password,String salt){
		String sql=" update USER_LOGIN ul set ul.PASSWORD='"+password+"',ul.SALT='"+salt+"'  where 1=1 and ul.ID='"+userLoginId+"' ";
		
		
		bdpJdbcTemplate.execute(sql);
	}
	
	
}
