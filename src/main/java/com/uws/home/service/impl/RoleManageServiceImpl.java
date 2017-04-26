package com.uws.home.service.impl;


import java.util.*;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IConfigManageDao;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.dao.IPermissionManageDao;
import com.uws.home.dao.IRoleManageDao;
import com.uws.home.dao.IRoleUserManageDao;
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
import com.uws.home.service.IRoleManageService;
import com.uws.user.model.Org;

/**
 * @ClassName    RoleManageServiceImpl
 * @Description  门户字典管理接口实现类
 * @author             联合永道
 * @date         2016-08-25下午16:14:22
 */
@Service("RoleManageServiceImpl")
public class RoleManageServiceImpl extends BaseServiceImpl implements IRoleManageService{
	@Autowired
	private IRoleManageDao iRoleManageDao;
	@Autowired
	private IRoleUserManageDao iRoleUserManageDao;
	@Autowired
	private IPermissionManageDao iPermissionManageDao;
	
	@Autowired
	private IDicManageService iDicManageService;
	
	@Autowired
	private IConfigManageService iConfigManageService;
	
	@Override
	public Page getMhRoleList(int pageNo,MhRoles mhRole){
		
		return this.iRoleManageDao.getMhRoleList(pageNo, mhRole);
	}
	
	
	public List<MhRoles> getAllMhRolesList(){
		return this.iRoleManageDao.getAllMhRolesList(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
	}
	
	
	@Override
	public MhRoles getMhRoleById(String mhRoleId){
		return this.iRoleManageDao.getMhRoleById(mhRoleId);
	}
	
	
	@Override
	public void saveMhRole(MhRoles mhRole){
		this.iRoleManageDao.saveMhRole(mhRole);
	}
	
	@Override
	public void delMhRole(String mhRoleId){
		MhDic mc=iDicManageService.getMhDicByParentCodeOrId("DELETED", "");
		MhRoles mr=this.iRoleManageDao.getMhRoleById(mhRoleId);
		mr.setDeleteStatus(mc);
		iRoleManageDao.saveMhRole(mr);
		iRoleUserManageDao.updateMhRoleUserByRoleId(mhRoleId,mc );
		iPermissionManageDao.updateMhPermissionByRoleId(mhRoleId, mc);
		
	}
	
	
	
	@Override
	public void allotDataPermisson(String collegeList,String roleId){
		//默认数据权限为所在学院——defualt_college
		MhRoles mr=this.iRoleManageDao.getMhRoleById(roleId);
		mr.setColleges(collegeList);
		this.iRoleManageDao.saveMhRole(mr);
		
	}
	
	
	//获取用户菜单权限
	@Override
	public List<MhMenu> getUserMenuPermisson(String userId){
		MhDic mc=iDicManageService.getMhDicByParentCodeOrId("NORMAL", "");
		List<MhRoleUser> list=iRoleUserManageDao.getMhRoleUserByUserIdOrRoleId(userId, "", mc);
		
		Map<String,MhMenu> map=new HashMap();
		
		for(MhRoleUser mr:list){
			List<MhPermission> list02=new ArrayList();
			if(mr!=null && mr.getMhRoleId()!=null && mr.getMhRoleId().getId()!=null){
			     list02=iPermissionManageDao.getMhPermissionByUserIdOrRoleId("", mr.getMhRoleId().getId(), mc);
			    if(list02!=null && list02.size()>0){
					for(MhPermission mp:list02){
						if(!map.containsKey(mp.getMhMenuId().getId())){
							map.put(mp.getMhMenuId().getId(),mp.getMhMenuId());
							
						}
						
					}
			    }
			}
		}
		
		List<MhMenu> list03=new ArrayList();
		for(String str:map.keySet()){
			list03.add(map.get(str));
			
		}
		
		return list03;
	}
	
	//获取用户数据权限
	@Override
	public Map<String,String> getUserDataPermisson(String userId){
		
		MhDic mc=iDicManageService.getMhDicByParentCodeOrId("NORMAL", "");
		List<MhRoleUser> list=iRoleUserManageDao.getMhRoleUserByUserIdOrRoleId(userId, "", mc);
		Map<String,String> map=new HashMap();
		List<String> list01=new ArrayList();
		String colleges="";
		
		for(MhRoleUser mrl:list){
			String collegeList="";
			if(mrl!=null && mrl.getMhRoleId()!=null){
			    collegeList=iRoleManageDao.getMhRoleById(mrl.getMhRoleId().getId()).getColleges();
			}
			if("defualt_college".equals(collegeList)){
				map.put("defualt_college", "defualt_college");
			}else{
				if(DataUtil.isNotNull(collegeList)){
					 String[] collegeArrs=collegeList.split(",");
					 for(int i=0;i<collegeArrs.length;i++){
						 if(!list01.contains(collegeArrs[i])){
						     list01.add(collegeArrs[i]);
						     colleges=colleges+collegeArrs[i]+",";
						 }
					 }
					 
				    
				}
			}
			
		}
		
		map.put("collegeList", colleges);
		
		return map;
	}
	
	@Override
	public MhRoles getMhRoleByCode(String mhRoleCode){
		
		return this.iRoleManageDao.getMhRoleByCode(mhRoleCode);
	}
	
	
	//获取用户可展示的菜单
	@Override
	public Map<String,List<MhMenu>> getUserVisiableMenu(String userId){
		    List<MhMenu> permissionMenu=getUserMenuPermisson(userId);
	        List<MhMenu> allMenu=new ArrayList();
	        
	        //给用户可展示的菜单进行排序
			List<MhMenu> viewList=new ArrayList();
			//权限管理，菜单自定义配置等操作按钮
			List<MhMenu> optList=new ArrayList();
	        
	        allMenu.addAll(permissionMenu);
	        MhConfig confi=iConfigManageService.getMhConfigByUserId(userId);
	        //System.out.println("allMenu.size============"+allMenu.size());
	        //根据用户自定义菜单配置来筛选用户可展示的菜单
			if(DataUtil.isNotNull(confi) && permissionMenu!=null && permissionMenu.size()>0){
				//System.out.println("permissionMenu.size============"+permissionMenu.size());
				if(DataUtil.isNotNull(confi.getMhMenus())){
					//System.out.println("confi.getMhMenus()============"+confi.getMhMenus());
					String[] configs=confi.getMhMenus().split(",");
					if(configs!=null && configs.length>0){
						//System.out.println("configs.length============"+configs.length);
						Iterator<MhMenu> itm=allMenu.iterator();
						MhMenu me=null;
						while(itm.hasNext()){
							me=itm.next();
							if(me.getMhMenuOrder()==0){
								optList.add(me);
								itm.remove();
							}else{
								for(int i=0;i<configs.length;i++){
									if(configs[i].equals(me.getId())){
										me.setMhMenuLevel(-1);
									}
								}
							}
						}
						
						
						//System.out.println("allMenu.size============"+allMenu.size());
						
						 int count=0;
						 Iterator<MhMenu> it = permissionMenu.iterator();
						 MhMenu temp = null;
					     while (it.hasNext()) {
					            temp = it.next();
					            for(int i=0;i<configs.length;i++){
									if(temp.getId().equals(configs[i])){
										count=count+1;
										break;
									}
								}
								if(count==0){
									//list.remove(mm);//报错
									it.remove();
								}
								count=0;
					    }
					    viewList.addAll(permissionMenu);
						//System.out.println("permissionMenu00001.size============"+permissionMenu.size());
					}else{
						Iterator<MhMenu> itm=allMenu.iterator();
						MhMenu me=null;
						while(itm.hasNext()){
							me=itm.next();
							if(me.getMhMenuOrder()==0){
								optList.add(me);
								itm.remove();
							}
						}
						
					}
				}else{
					Iterator<MhMenu> itm=allMenu.iterator();
					MhMenu me=null;
					while(itm.hasNext()){
						me=itm.next();
						if(me.getMhMenuOrder()==0){
							optList.add(me);
							itm.remove();
						}
					}
					//permissionMenu.clear();
					//System.out.println("===============permissionMenu.clear============");
				}
			}else{
	        
				//System.out.println("permissionMenu00002.size============"+permissionMenu.size());
				
					if(allMenu!=null && allMenu.size()>0){
						Iterator<MhMenu> ir=allMenu.iterator();
						
						MhMenu mnu=null;
						while(ir.hasNext()){
							mnu=ir.next();
							if(mnu.getMhMenuOrder()==0){
								optList.add(mnu);
								ir.remove();
							}
						}
						
						viewList.addAll(allMenu);
					}
				
			}
			
			//System.out.println("allMenu.size0000============"+allMenu.size());
			//System.out.println("viewList.size0000============"+viewList.size());
			//System.out.println("optList.size0000============"+optList.size());
			
			
			//给菜单排序
			Collections.sort(viewList);
			
			Map<String,List<MhMenu>> map=new HashMap();
			map.put("allMenu", allMenu);
			map.put("viewList", viewList);
			map.put("optList", optList);
				
			return map;
	}
	
	
	@Override
	public List<MhRoles> getMhRoleByName(String mhRoleName){
		
		
		return this.iRoleManageDao.getMhRoleByName(mhRoleName);
	}
	
	
}
