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
import com.uws.home.dao.IRoleUserManageDao;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhRoles;
import com.uws.home.model.MhRoleUser;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.IRoleUserManageService;
import com.uws.user.model.Org;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;

/**
 * @ClassName    RoleUserManageServiceImpl
 * @Description  门户用户与角色关系管理接口实现类
 * @author             hejin
 * @date         2016-09-05下午17:34:22
 */
@Service("RoleUserManageServiceImpl")
public class RoleUserManageServiceImpl extends BaseServiceImpl implements IRoleUserManageService{
	@Autowired
	private IRoleUserManageDao iRoleUserManageDao;
	@Autowired
	private IDicManageService iDicManageService;
	
	@Override
	public void saveMhRoleUser(MhRoleUser mhRoleUser){
		this.iRoleUserManageDao.saveMhRoleUser(mhRoleUser);
		
	}
	
	@Override
	public User getUserById(String userId){
		
		return this.iRoleUserManageDao.getUserById(userId);
	}

	@Override
	public Page getUserList(String name,int pageNo){
		
		return this.iRoleUserManageDao.getUserList(name,pageNo);
	}

	@Override
	public List<Org> getAllOrg(){
		
		return this.iRoleUserManageDao.getAllOrg();
	};
	
	@Override
	public List<MhRoleUser> getMhRoleUserByUserIdOrRoleId(String userId,String roleId){
		
		return this.iRoleUserManageDao.getMhRoleUserByUserIdOrRoleId(userId, roleId, iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
	};
	
	
	@Override
	public void allotUser(String userList,String roleId,int pageNo){
		MhDic mc=iDicManageService.getMhDicByParentCodeOrId("NORMAL", "");//正常
		MhDic mc01=iDicManageService.getMhDicByParentCodeOrId("DELETED", "");//删除
		List<MhRoleUser> list=this.iRoleUserManageDao.getMhRoleUserByUserIdOrRoleId("", roleId, mc);
		
		if(list.size()>0){
			//System.out.println("list==roleUser01========"+list.size());
			List<MhRoleUser> list01=new ArrayList();
			list01.addAll(list);
			if(userList!=null && userList!=""){
				
				String[] userArs=userList.split(",");
				int t=0;
				List<MhRoleUser> list03=new ArrayList();
				for(int i=0;i<userArs.length;i++){
					//System.out.println("userArs["+i+"]===="+userArs[i]);
					Iterator<MhRoleUser> it=list01.iterator();
					MhRoleUser mru=null;
					while(it.hasNext()){
						
						mru=it.next();
						if(userArs[i].equals(mru.getMhUserid().getId())){
							//System.out.println("userArs["+i+"]==00=="+userArs[i]);
							t=t+1;
							it.remove();
						}
					}
					
					if(t==0){
						MhRoleUser mu=new MhRoleUser();
						MhRoles role=new MhRoles();
						role.setId(roleId);
						User user01=new User();
						user01.setId(userArs[i]);
						
						mu.setDeleteStatus(mc);
						mu.setMhRoleId(role);
						mu.setMhUserid(user01);
						this.iRoleUserManageDao.saveMhRoleUser(mu);
					}
					t=0;
				}
				
				if(list01!=null&&list01.size()>0){
					//System.out.println("aaaaa003==list01.size======"+list01.size());
					for(MhRoleUser ml:list01){
						ml.setDeleteStatus(mc01);
						this.iRoleUserManageDao.saveMhRoleUser(ml);
					}
				}
			}else{
				
				if(list01!=null ){
						for(MhRoleUser mle:list01){
							
							mle.setDeleteStatus(mc01);
							this.iRoleUserManageDao.saveMhRoleUser(mle);
							
						}
				}
				
			}
		}else{
            if(userList!=null && userList!=""){
            	String[] userArs=userList.split(",");
            	//System.out.println("aaaaa004========");
				for(int i=0;i<userArs.length;i++){
					MhRoleUser mu=new MhRoleUser();
					MhRoles role=new MhRoles();
					role.setId(roleId);
					User user01=new User();
					user01.setId(userArs[i]);
					
					mu.setDeleteStatus(mc);
					mu.setMhRoleId(role);
					mu.setMhUserid(user01);
					this.iRoleUserManageDao.saveMhRoleUser(mu);
				}
				
			}
            //System.out.println("aaaaa005========");
		}
	}
	
	@Override
	public UserLogin getLoginUser(String userId){
		
		return this.iRoleUserManageDao.getLoginUser(userId);
	}
	
	@Override
	public void updateUserPassword(String userId){
		UserLogin userLogin=this.iRoleUserManageDao.getLoginUser(userId);
		
		iRoleUserManageDao.updatePassword(userLogin.getId(), userLogin.getPassword(),userLogin.getSalt());
	}
	
}
