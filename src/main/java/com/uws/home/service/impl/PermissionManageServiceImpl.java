package com.uws.home.service.impl;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.dao.IConfigManageDao;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.dao.IPermissionManageDao;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoles;
import com.uws.home.model.MhRoleUser;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.IPermissionManageService;
import com.uws.user.model.User;

/**
 * @ClassName    PermissionManageServiceImpl
 * @Description  门户菜单与角色关系管理接口实现类
 * @author             hejin
 * @date         2016-09-05下午23:14:22
 */
@Service("PermissionManageServiceImpl")
public class PermissionManageServiceImpl extends BaseServiceImpl implements IPermissionManageService{
	@Autowired
	private IPermissionManageDao iPermissionManageDao;
	@Autowired
	private IDicManageService iDicManageService;
	
	@Override  
	public void saveMhPermission(MhPermission mhPermission){
		
		iPermissionManageDao.saveMhPermission(mhPermission);
	}
	
	@Override 
    public void allotMhMenu(String mhMenuList,String roleId){
    	MhDic mc=iDicManageService.getMhDicByParentCodeOrId("NORMAL", "");//正常
		MhDic mc01=iDicManageService.getMhDicByParentCodeOrId("DELETED", "");//删除
		List<MhPermission> list=this.iPermissionManageDao.getMhPermissionByUserIdOrRoleId("", roleId, mc);
		
		List<MhPermission> list02=new ArrayList();
		
		//System.out.println("================mhMenuList============"+mhMenuList);
		if(list.size()>0){
			if(mhMenuList!=null && mhMenuList!=""){
				//System.out.println("PermissionManage=======list.size============"+list.size());
				String[] userArs=mhMenuList.split(",");
				//System.out.println("PermissionManage=======userArs.length============"+userArs.length);
				int t=0;
				for(int i=0;i<userArs.length;i++){
					Iterator<MhPermission> it=list.iterator();
					MhPermission mp=null;
					while(it.hasNext()){
						mp=it.next();
						if(userArs[i].equals(mp.getId())){
							t=t+1;
							it.remove();
							//System.out.println("==========PermissionManage>>>>>>>>=======list02============");
						}
						//System.out.println("==========<<<<<<<<<<<<PermissionManage=======list02============");
					}
					
					if(t==0){
						
						MhPermission mu=new MhPermission();
						MhRoles role=new MhRoles();
						role.setId(roleId);
						MhMenu mhMenu=new MhMenu();
						mhMenu.setId(userArs[i]);
						//System.out.println("PermissionManage=======roleId============"+roleId);
						mu.setDeleteStatus(mc);
						mu.setMhRoleid(role);
						mu.setMhMenuId(mhMenu);
						this.iPermissionManageDao.saveMhPermission(mu);
					}
					t=0;
				}
				
				//System.out.println("PermissionManage002=======list.size============"+list.size());
				
				if(list!=null && list.size()>0){
					for(MhPermission ml:list){
						ml.setDeleteStatus(mc01);
						this.iPermissionManageDao.saveMhPermission(ml);
						//System.out.println("================PermissionManage=======delete============");
					}
				}
			}else{
				//System.out.println("================PermissionManage=======deleteAll============");
				this.iPermissionManageDao.updateMhPermissionByRoleId(roleId, mc01);
			}
		}else{
			//System.out.println("================PermissionManage=======add============");
            if(mhMenuList!=null && mhMenuList!=""){
            	String[] userArs=mhMenuList.split(",");
            	//System.out.println("PermissionManage003=======userArs.length============"+userArs.length);
				for(int i=0;i<userArs.length;i++){
					MhPermission mu=new MhPermission();
					MhRoles role=new MhRoles();
					role.setId(roleId);
					MhMenu mhMenu=new MhMenu();
					mhMenu.setId(userArs[i]);
					//System.out.println("==============PermissionManage004=============");
					mu.setDeleteStatus(mc);
					mu.setMhRoleid(role);
					mu.setMhMenuId(mhMenu);
					this.iPermissionManageDao.saveMhPermission(mu);
				}
				
			}
		}
    	
    }
	
	@Override
	public List<MhPermission> getMhPermissionByRoleId(String roleId){
		List<MhPermission> list=iPermissionManageDao.getMhPermissionByUserIdOrRoleId("", roleId, iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
		
		return list;
	}
	
}
