package com.uws.home.dao.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.dao.IRoleManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoles;
/**
 * 门户角色管理实现类
 * @author hejin
 *
 */
@Repository("RoleManageDaoImpl")
public class RoleManageDaoImpl extends BaseDaoImpl implements IRoleManageDao{
	
	@Autowired
	private IDicManageDao iDicManageDao;

	@Override
	public Page getMhRoleList(int pageNo,MhRoles mhRole){
		StringBuffer hql=new StringBuffer("select mr from MhRole mr where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(mhRole)){
			if(DataUtil.isNotNull(mhRole.getMhRoleName())){
				hql.append(" and mr.mhRoleName like ?  ");
				values.add("%"+mhRole.getMhRoleName()+"%");
				
			}
			if(DataUtil.isNotNull(mhRole.getMhRoleCode())){
				hql.append(" and mr.mhRoleCode like ?  ");
				values.add("%"+mhRole.getMhRoleCode()+"%");
				
			}
			
			if(DataUtil.isNotNull(mhRole.getMhRoleType())){
				hql.append(" and mr.mhRoleType.id = ?  ");
				values.add(mhRole.getMhRoleType().getId());
				
			}
			
			if(DataUtil.isNotNull(mhRole.getDeleteStatus())){
				hql.append(" and mr.deleteStatus = ?  ");
				values.add(mhRole.getDeleteStatus());
				
			}
			
		}
		
		hql.append(" order by updateTime desc ");
		if (values.size() == 0){
			return this.pagedQuery(hql.toString(), pageNo, 10);
		}else{
			return this.pagedQuery(hql.toString(),pageNo, 10,values.toArray() );
		}
		
	}
	
	
	@Override
	public List<MhRoles> getAllMhRolesList(MhDic mhDic){
		StringBuffer hql=new StringBuffer(" select mr from MhRoles mr where 1=1 and mr.deleteStatus = ? ");
		List<Object> values=new ArrayList();
		values.add(mhDic);
		hql.append(" order by updateTime desc ");
		List<MhRoles> list=(List<MhRoles>)this.query(hql.toString(), values.toArray());
		
        return list;
		
	}
	
	
	@Override
	public MhRoles getMhRoleById(String mhRoleId){
		
		
		return (MhRoles)this.get(MhRoles.class, mhRoleId);
		
	 }
	
	@Override
	public void saveMhRole(MhRoles mhRole){
		
		this.save(mhRole);
	}
	
	@Override
	public MhRoles getMhRoleByCode(String mhRoleCode){
		MhDic mc=iDicManageDao.getMhDicByParentCodeOrId("NORMAL", "");
		StringBuffer hql=new StringBuffer(" select mr from MhRoles mr where 1=1 and mr.mhRoleCode = ? and mr.deleteStatus = ? ");
		
		return (MhRoles)this.queryUnique(hql.toString(), new Object[]{mhRoleCode,mc});
	}
	
	
	@Override
	public List<MhRoles> getMhRoleByName(String mhRoleName){
		MhDic mc=iDicManageDao.getMhDicByParentCodeOrId("NORMAL", "");
		StringBuffer hql=new StringBuffer(" select mr from MhRoles mr where 1=1 and mr.mhRoleName = ? and mr.deleteStatus = ? ");
		
		return (List<MhRoles>)this.query(hql.toString(), new Object[]{mhRoleName,mc});
	}
	
}
