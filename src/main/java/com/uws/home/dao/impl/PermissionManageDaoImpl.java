package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.dao.IPermissionManageDao;
import com.uws.home.dao.IRoleUserManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoleUser;
/**
 * 门户角色与菜单关系管理实现类
 * @author hejin
 *
 */
@Repository("PermissionManageDaoImpl")
public class PermissionManageDaoImpl extends BaseDaoImpl implements IPermissionManageDao{

	@Override
	public void saveMhPermission(MhPermission mhPermission){
		this.save(mhPermission);
	}
	
	@Override
	public List<MhPermission> getMhPermissionByUserIdOrRoleId(String menuId,String roleId,MhDic mhDic){
		
		StringBuffer hql=new StringBuffer("select ru from MhPermission ru where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(menuId)){
			hql.append(" and ru.mhMenuId.id = ?  ");
			values.add(menuId);
			
		}
		
		if(DataUtil.isNotNull(roleId)){
			hql.append(" and ru.mhRoleid.id = ?  ");
			values.add(roleId);
			
		}
		
		if(DataUtil.isNotNull(mhDic)){
			hql.append(" and ru.deleteStatus = ?  ");
			values.add(mhDic);
			
		}
		List<MhPermission> list=this.query(hql.toString(), values.toArray());
		//System.out.println("dao=======list.size============"+list.size());
		return (List<MhPermission>)this.query(hql.toString(), values.toArray());
		
	 }
	
	@Override
	public void updateMhPermissionByRoleId(String roleId,MhDic mhDic){
		StringBuffer hql=new StringBuffer("update MhPermission mss  set mss.deleteStatus=? where mss.mhRoleid.id=? ");
		List<Object> values=new ArrayList();
		
		values.add(mhDic);
		values.add(roleId);
		this.executeHql(hql.toString(), values.toArray());
		
	}
	
}
