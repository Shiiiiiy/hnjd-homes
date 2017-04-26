package com.uws.home.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.session.SessionFactory;
import com.uws.core.session.SessionUtil;
import com.uws.core.util.DataUtil;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhPermission;
import com.uws.home.model.MhRoles;
import com.uws.home.model.MhRoleUser;
import com.uws.home.model.MhTeacherUser;
import com.uws.home.model.UserDTO;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IInteractService;
import com.uws.home.service.IMenuManageService;
import com.uws.home.service.IMessageService;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.IPermissionManageService;
import com.uws.home.service.IRoleManageService;
import com.uws.home.service.IRoleUserManageService;
import com.uws.home.service.TeacherPortalService;
import com.uws.sys.model.Dic;
import com.uws.user.model.Org;
import com.uws.user.model.User;

/**
 * @ClassName    PermissionController
 * @Description  门户权限管理controller
 * @author       何进
 * @date         2016-9-5上午10:30:22
 */
@Controller
public class PermissionController {
      

	@Autowired
	private IDicManageService iDicManageService;
	
	@Autowired
	private IMenuManageService iMenuManageService;
	
	@Autowired
	private IPermissionManageService iPermissionManageService;
	
	@Autowired
	private IRoleManageService iRoleManageService;
	
	@Autowired
	private IRoleUserManageService iRoleUserManageService;
	
	 //属性编辑器
    @InitBinder
    protected void initBinder(HttpServletRequest request,
                ServletRequestDataBinder binder) throws Exception {
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        CustomDateEditor dateEditor = new CustomDateEditor(format, true);
        binder.registerCustomEditor(Date.class, dateEditor);
    }
    
	
    /**
	 * 查询角色列表
	 * */
	@RequestMapping("/menhu/opt-query/queryRoleList" )
	public String queryRoleList(ModelMap model,HttpServletRequest request,HttpServletResponse response){
	
		List<MhRoles> roleList=this.iRoleManageService.getAllMhRolesList();
		
		
		//列表分页数据
		model.addAttribute("roleList", roleList);
		return "/home/newsManage/permissionManage";
	}
	

	

    /**
	 * 新增或修改角色页面
	 * */
	@RequestMapping("/menhu/opt-add/addOrEditRole" )
	public String addOrEditRole(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String mhRoleId=request.getParameter("mhRoleId");
		
		
		//角色类型列表
		List<MhDic> roleTypeList=iDicManageService.getMhDicListByParentCode("ROLE_TYPE");
		//启用状态列表
		List<MhDic> statusList=iDicManageService.getMhDicListByParentCode("STATUS");
        if(DataUtil.isNotNull(mhRoleId)){//修改
        	MhRoles mhRole=iRoleManageService.getMhRoleById(mhRoleId);
        	
        	model.addAttribute("mhRole",mhRole);
		}
        model.addAttribute("statusList",statusList);
        model.addAttribute("roleTypeList",roleTypeList);
        
        
		return "/home/newsManage/addOrEditRole";
	}
	
	
	/**
	 *保存角色
	 * */
	@RequestMapping("/menhu/opt-save/saveRole" )
	public String saveRole(ModelMap model,MhRoles mhRole, HttpServletRequest request,HttpServletResponse response){
		String flag=request.getParameter("flag");
        if(DataUtil.isNotNull(mhRole.getId())){//修改
        	MhRoles mhRole01=iRoleManageService.getMhRoleById(mhRole.getId());
        	mhRole01.setMhRoleCode(mhRole.getMhRoleCode());
        	mhRole01.setMhRoleName(mhRole.getMhRoleName());
        	mhRole01.setMhRoleType(mhRole.getMhRoleType());
        	mhRole01.setStatus(mhRole.getStatus());
        	iRoleManageService.saveMhRole(mhRole01);
        	return "redirect:/menhu/opt-query/queryRoleList.do?flag=1";
		}else{//新增
			mhRole.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
			iRoleManageService.saveMhRole(mhRole);
			return "redirect:/menhu/opt-query/queryRoleList.do";
		}
	}
	
	
	/**
	 *选择用户列表页面
	 * */
	@RequestMapping("/menhu/opt-query/queryMhUserList" )
	public String queryMhUserList(ModelMap model,HttpSession session ,HttpServletRequest request,HttpServletResponse response){
		
		String  roleId=request.getParameter("mhRoleId");
		String  name=request.getParameter("name");
		
		if(DataUtil.isNotNull(name)){
			try {
				name=new String(name.getBytes("ISO8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		int pageNo = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue() : 1;
		Page page=iRoleUserManageService.getUserList(name,pageNo);
		List<MhRoleUser> selectedList=iRoleUserManageService.getMhRoleUserByUserIdOrRoleId("", roleId);
		List<User> list=(List<User>)page.getResult();
		
		if(selectedList!=null && selectedList.size()>0){
			for(MhRoleUser mr:selectedList){
				for(User mu:list){
				   if(mr.getMhUserid()!=null){	
						if(mr.getMhUserid().getId().equals(mu.getId())){
							mu.setAddress("ok");
							break;
						}
				   }
				}
				
			}
		}
		
		
		page.setResult(list);
		session.setAttribute("name", name);
		model.addAttribute("page",page);
		model.addAttribute("totalCount",page.getTotalCount());
		model.addAttribute("selectedList",selectedList);
		model.addAttribute("roleId",roleId);
		model.addAttribute("pageNo",pageNo);
		return "/home/newsManage/allotUser";
	}
	
	
	/**
	 *异步获取用户列表
	 * */
	@RequestMapping("/menhu/opt-query/queryMhUserListByAjax" )
	public void queryMhUserListByAjax(HttpServletRequest request,HttpServletResponse response){
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String  roleId=request.getParameter("roleId");
		String  name=request.getParameter("name");
		String  sta=request.getParameter("sta");
		
		int pageNo01 = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue(): 1;
		int pageNo=1;
		if("up".equals(sta)){
			pageNo=pageNo01-1;
		}else if("down".equals(sta)){
			pageNo=pageNo01+1;
		}
		
		List<User> pageList=(List<User>)iRoleUserManageService.getUserList(name,pageNo).getResult();
		List<MhRoleUser> selectedList=iRoleUserManageService.getMhRoleUserByUserIdOrRoleId("", roleId);
		
		if(selectedList!=null && selectedList.size()>0){
			for(MhRoleUser mr:selectedList){
				for(User mu:pageList){
					if(mr.getMhUserid()!=null){	
						if(mr.getMhUserid().getId().equals(mu.getId())){
							mu.setAddress("ok");
							break;
						}
					}
					
				}
				
			}
		}
		

		JSONObject jsonObj  = new JSONObject();
		if(pageList!=null && pageList.size()>0){
			List<UserDTO> list=new ArrayList();
			for(User user:pageList){
				UserDTO ud=new UserDTO();
				ud.setCertNum(user.getCertNum());
				ud.setCertType(user.getCertTypeDic()!=null?user.getCertTypeDic().getName():"");
				ud.setGender(user.getGenderDic()!=null?user.getGenderDic().getName():"");
				ud.setId(user.getId());
			    ud.setName(user.getName());
			    ud.setAddress(user.getAddress());
			    list.add(ud);
			}
            jsonObj.put("result", list);
            jsonObj.put("pageNo", pageNo);
		}else{
			jsonObj.put("result", "no");
			jsonObj.put("pageNo", pageNo-1);
		}
		
		JSONObject json = JSONObject.fromObject(jsonObj);
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 *选择菜单列表
	 * */
	@RequestMapping("/menhu/opt-query/queryMhMenuList" )
	public String queryMhMenuList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String  roleId=request.getParameter("mhRoleId");
		List<MhMenu> list=iMenuManageService.getAllMenuList(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
		List<MhPermission> list01=iPermissionManageService.getMhPermissionByRoleId(roleId);
		if(list01!=null && list01.size()>0){
			for(MhPermission mn: list01){
				
				for(MhMenu mu:list){
					if(mn.getMhMenuId().getId().equals(mu.getId())){
						mu.setComments("ok");
						break;
					}
				}
				
			}
		}
		
		model.addAttribute("roleId",roleId);
		model.addAttribute("menuList", list);
		return "/home/newsManage/allotMenu";
	}
	
	
	
	/**
	 *数据权限分配页面
	 * */
	@RequestMapping("/menhu/opt-query/queryMhcollegesList" )
	public String queryMhcollegesList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String  roleId=request.getParameter("mhRoleId");
		
		List<Org> collegeList=iRoleUserManageService.getAllOrg();
		String colleges=iRoleManageService.getMhRoleById(roleId).getColleges();
		if(DataUtil.isNotNull(colleges) && !"defualt_college".equals(colleges)){
			String[] str=colleges.split(",");
			for(int i=0;i<str.length;i++){
				for(Org og:collegeList){
					if(str[i].equals(og.getId())){
						og.setPath("ok");
						break;
					}
				}
			}
		}else if("defualt_college".equals(colleges)){
			
		}
		
		model.addAttribute("roleId", roleId);
		model.addAttribute("collegeList", collegeList);
		
		return "/home/newsManage/allotDataPermission";
	}
	
	
	/**
	 *用户，菜单，数据权限分配保存
	 * */
	@RequestMapping("/menhu/opt-save/savePermissions" )
	public String savePermissions( HttpServletRequest request,HttpServletResponse response){
		String  content=request.getParameter("content");
		String  roleId=request.getParameter("roleId");
		String  flag=request.getParameter("flag");
		int pageNo = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue() : 1;
		if("user".equals(flag)){
			
			iRoleUserManageService.allotUser(content, roleId,pageNo);
		}else if("menu".equals(flag)){
			iPermissionManageService.allotMhMenu(content, roleId);
		}else if("college".equals(flag)){
			
			iRoleManageService.allotDataPermisson(content, roleId);
			
		}
		
		return "redirect:/menhu/opt-query/queryRoleList.do";
	}
	
	
	/**
	 *删除角色
	 * */
	@RequestMapping("/menhu/opt-del/delMhRole" )
	public String delMhRole(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String mhRoleId=request.getParameter("mhRoleId");
		iRoleManageService.delMhRole(mhRoleId);
		return "redirect:/menhu/opt-query/queryRoleList.do";
	}
	
	
	/**
	 *校验角色编码是否重复
	 * */
	@RequestMapping("/menhu/opt-query/checkMhRoleCode" )
	public void checkMhRoleCode(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String codes=request.getParameter("codes");
		String roleName=request.getParameter("roleName");
		String roleId=request.getParameter("roleId");
		
		MhRoles mr=iRoleManageService.getMhRoleByCode(codes);
		List<MhRoles> mrList=iRoleManageService.getMhRoleByName(roleName);
		
		
		JSONObject jsonObj  = new JSONObject();
		if(mr!=null && DataUtil.isNotNull(mr.getId())){
			if(DataUtil.isNotNull(roleId) && mr.getId().equals(roleId)){
				jsonObj.put("codeStat", "ok");
			}else{
				jsonObj.put("codeStat", "no");
			}
			
		}else{
			jsonObj.put("codeStat", "ok");
			
		}
		
        if(mrList!=null && mrList.size()>0){
        	if(DataUtil.isNotNull(roleId) && mrList.get(0).getId().equals(roleId)){
				jsonObj.put("nameStat", "ok");
			}else{
				jsonObj.put("nameStat", "no");
			}

		}else{
			jsonObj.put("nameStat", "ok");
			
		}
		
        JSONObject json = JSONObject.fromObject(jsonObj);
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
