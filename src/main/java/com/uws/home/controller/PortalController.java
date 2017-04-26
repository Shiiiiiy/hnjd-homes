package com.uws.home.controller;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.uws.core.base.BaseController;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.session.SessionFactory;
import com.uws.core.session.SessionUtil;
import com.uws.core.util.DataUtil;
import com.uws.core.util.IdUtil;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoleUser;
import com.uws.home.model.MhRoles;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;
import com.uws.home.model.SynchronizedChargeDetialModel;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IMenuManageService;
import com.uws.home.service.IPermissionManageService;
import com.uws.home.service.IRoleManageService;
import com.uws.home.service.IRoleUserManageService;
import com.uws.home.service.StudentPortalService;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;
/** 
* @Description:门户网站的控制层
*/
@Controller
public class PortalController extends BaseController{
	@Autowired
	public StudentPortalService  studentPortalService;

	
	@Autowired
	private IRoleManageService iRoleManageService;
	
	@Autowired
	private IRoleUserManageService iRoleUserManageService;
	
	@Autowired
	private IDicManageService iDicManageService;
	
	@Autowired
	private IPermissionManageService iPermissionManageService;
	
	@Autowired
	private IConfigManageService iConfigManageService;
	
	
	/**
	 * 根据用户类型判断进入 不同的页面
	 * */
	@RequestMapping("/Portal/opt-query/gotoPortal")
	public String gotoPortal(ModelMap model,HttpSession session,HttpServletRequest request,HttpServletResponse response){
		//门户预留功能  
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
        String userId = sessionUtil.getCurrentUserId();//用户
		String LoginName = sessionUtil.getCurrentLoginName();//帐号   学生依据这个
		String usertype=this.studentPortalService.isTeaOrStu(userId);
		
		//保存用户登录信息
		User user01=iRoleUserManageService.getUserById(userId);
		session.setAttribute("login_userName", user01.getName());
		session.setAttribute("login_userId", user01.getId());
		UserLogin us=this.iRoleUserManageService.getLoginUser(userId);
		session.setAttribute("the_login_account",us!=null?us.getLoginName():"");
		//
		String login_userType="";
		boolean bn=user01.getIsSuperUser()=="1" || user01.getUserType()==null ;
		login_userType=bn ?"TEACHER":user01.getUserType().getCode();
		session.setAttribute("login_userType",  login_userType);
		session.setAttribute("login_isSuperUser", user01.getIsSuperUser());
		
		//进行判断 
		if("SYS".equals(usertype)){//判断是教师用户
			//初始化用户默认角色和权限
			List<MhRoleUser>  list002=iRoleUserManageService.getMhRoleUserByUserIdOrRoleId(userId, "");
			if(list002.size()==0){ 
				User user=new User();
				user.setId(userId);
				MhRoles role=iRoleManageService.getMhRoleByCode("SYSTEM_ROLE");
				
				
				MhRoleUser mru=new MhRoleUser();
				mru.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
				mru.setMhRoleId(role);
				mru.setMhUserid(user);
				mru.setStatus(iDicManageService.getMhDicByParentCodeOrId("STATUS_OK", ""));
				iRoleUserManageService.saveMhRoleUser(mru);
				
				String menuConfig="";
				
				List<MhPermission> list01=iPermissionManageService.getMhPermissionByRoleId(role.getId());
				if(list01!=null && list01.size()>0){
					for(MhPermission mr:list01){
						if(mr.getMhMenuId().getMhMenuOrder()>0){
							menuConfig=menuConfig+mr.getMhMenuId().getId()+",";
						}
					}
				}
				
				MhConfig mc=iConfigManageService.getMhConfigByUserId(userId);
				
				if(mc!=null && DataUtil.isNotNull(mc.getId())){
					mc.setMhMenus(menuConfig);
					iConfigManageService.saveMhConfig(mc);
				}else{
					
					MhConfig mc01=new MhConfig();
					mc01.setMhMenus(menuConfig);
					mc01.setMhUserid(user);
					mc01.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
					iConfigManageService.saveMhConfig(mc01);
				}
			}	
			return "redirect:/menhu/opt-query/queryMenhuNewsList.do?superuser=true";
		}else if("TEA".equals(usertype)){//判断是教师用户
			
			//初始化用户默认角色和权限
			List<MhRoleUser>  list=iRoleUserManageService.getMhRoleUserByUserIdOrRoleId(userId, "");
			if(list.size()==0){ 
				User user=new User();
				user.setId(userId);
				MhRoles role=iRoleManageService.getMhRoleByCode("DEFAULT_ROLE");
				
				
				MhRoleUser mru=new MhRoleUser();
				mru.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
				mru.setMhRoleId(role);
				mru.setMhUserid(user);
				mru.setStatus(iDicManageService.getMhDicByParentCodeOrId("STATUS_OK", ""));
				iRoleUserManageService.saveMhRoleUser(mru);
				
				String menuConfig="";
				
				List<MhPermission> list01=iPermissionManageService.getMhPermissionByRoleId(role.getId());
				if(list01!=null && list01.size()>0){
					for(MhPermission mr:list01){
						if(mr.getMhMenuId().getMhMenuOrder()>0){
							menuConfig=menuConfig+mr.getMhMenuId().getId()+",";
						}
					}
				}
				
				MhConfig mc=iConfigManageService.getMhConfigByUserId(userId);
				
				if(mc!=null && DataUtil.isNotNull(mc.getId())){
					mc.setMhMenus(menuConfig);
					iConfigManageService.saveMhConfig(mc);
				}else{
					
					MhConfig mc01=new MhConfig();
					mc01.setMhMenus(menuConfig);
					mc01.setMhUserid(user);
					mc01.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
					iConfigManageService.saveMhConfig(mc01);
				}
				
			}
			return "redirect:/menhu/opt-query/queryMenhuNewsList.do";
		}else if("STU".equals(usertype)){//判断是学生用户
			return "redirect:/studentPortal/opt-query/studentPortalShow.do";
		}else{//其他	 类型注销并送回登录 用系统的注销
			return "redirect:/logout.do";
		}
	}
	/**
	 * 第三方对接  与双元微课 系统进行单点对接
	 * */
	@RequestMapping("/Portal/opt-query/gotoHnjdxy")
	public String gotoHnjdxy(HttpServletRequest request,HttpServletResponse response){
		return "/home/newsManage/checkHnjdxyLogin";
	}
}
