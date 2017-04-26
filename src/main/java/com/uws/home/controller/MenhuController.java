package com.uws.home.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.session.SessionFactory;
import com.uws.core.session.SessionUtil;
import com.uws.core.util.DataUtil;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhTeacherUser;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IInteractService;
import com.uws.home.service.IMessageService;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.IRoleManageService;
import com.uws.home.service.IRoleUserManageService;
import com.uws.home.service.TeacherPortalService;
import com.uws.user.model.User;
import com.uws.user.model.UserLogin;

/**
 * @ClassName    MenhuController
 * @Description  门户首页controller
 * @author       何进
 * @date         2016-8-29下午13:39:22
 */
@Controller
public class MenhuController {
      
	
	@Autowired
	private INewsManageService iNewsManageService;
	
	
	@Autowired
	private IInteractService iInteractService;
	
	@Autowired
	private IMessageService iMessageService;
	
	@Autowired
	private IDicManageService iDicManageService;
	@Autowired
	private IConfigManageService iConfigManageService;
	
	@Autowired
	public TeacherPortalService  teacherPortalService;

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
	 * 教师门户视图
	 * */
	@RequestMapping("/menhu/opt-query/queryMenhuNewsList" )
	public String queryMenhuNewsList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId = sessionUtil.getCurrentUserId();
		UserLogin loginUser=iRoleUserManageService.getLoginUser(userId);
		String loginName="";
		if(loginUser!=null && DataUtil.isNotNull(loginUser.getLoginName())){
			loginName=loginUser.getLoginName();
		}
		//新闻列表
		/*List<MhNews> mhNewslist01=(List<MhNews>)this.iNewsManageService.queryNewsList("", "", 1).getResult();
		List<MhNews> mhNewslist=new ArrayList();
		
		if(mhNewslist01!=null && mhNewslist01.size()>3){
			for(int i=0;i<mhNewslist01.size();i++){
				if(i<3){
					mhNewslist.add(mhNewslist01.get(i));
				}
				
			}
			
		}else{
			mhNewslist.addAll(mhNewslist01);
		}*/
		
		
		//教学互动
		MhInteract mit=iInteractService.getInteractByUserId(userId);
		
		//评论列表
		List<MhMessage> mhMessageList=iMessageService.getUserAllMessagesByMhOwnerId(userId);
		String read=iDicManageService.getMhDicByParentCodeOrId("READ", "").getId();//已读
		String unread=iDicManageService.getMhDicByParentCodeOrId("UNREAD", "").getId();//未读
		int x=0;
		for(MhMessage mhm:mhMessageList){
			if(mhm.getMhIsread().getId().equals(unread)){
				x=x+1;
			}
		}
		
	
		
      //开始
      		MhTeacherUser TeaUser=new MhTeacherUser();
      		List<String> schyearList=new ArrayList<String>();
      		List<String> academyList=new ArrayList<String>();
      		String schyear="";
      		if(request.getSession().getAttribute("TeaUser")!=null &&
      		   request.getSession().getAttribute("academyList")!=null &&	
      	       request.getSession().getAttribute("schyearList")!=null	){
      		   TeaUser=(MhTeacherUser) request.getSession().getAttribute("TeaUser");
      		   schyearList=(List<String>) request.getSession().getAttribute("schyearList");
      		   academyList=(List<String>) request.getSession().getAttribute("academyList");
      		   schyear=TeaUser.getNowYear();
      		}else{//是第一次  那么从数据库封装上述信息	
      			TeaUser=this.teacherPortalService.getMhTeacherUser(userId);
      			String issuperuser=request.getParameter("superuser");
      			if(issuperuser!=null && !("".equals(issuperuser)) && "true".equals(issuperuser)){
      				TeaUser.setIsFullPower("true");
      			}//管理员加判断 
      			//门户主页面其他参数展示 需要调用的数据 
      			schyearList=this.teacherPortalService.queryAllShooolYears();       //查询所有可用学年
      			academyList=this.teacherPortalService.queryAllAcademy(TeaUser);    //查询所有有权限学院
      			request.getSession().setAttribute("schyearList", schyearList);//放session
      			request.getSession().setAttribute("academyList", academyList);//放session
      			//当前学年修正
      			schyear=TeaUser.getNowYear(); int size=schyearList.size();
      			if(size>=1){
	      			if(Integer.valueOf(schyear)>Integer.valueOf(schyearList.get(0)) ){schyear=schyearList.get(0);}
	      			if(Integer.valueOf(schyear)<Integer.valueOf(schyearList.get(size-1)) ){schyear=schyearList.get(size-1);}
	      				TeaUser.setNowYear(schyear);
      			}
      			request.getSession().setAttribute("TeaUser", TeaUser);//放session修正 时间后 才保存用户信息
      		}	
      		//修正 有权限的学院 [没有权限 连主页面数值也不展示]
      		String academyN="";   	
      		List<String> ORG_NAMES=TeaUser.getORG_NAME();
      		if(ORG_NAMES.size()>=1){academyN=ORG_NAMES.get(0);}
      		//主页展示数据1       需要展示的 行政 教务比[作废]
//      		String[] teacherTypeNum=new String[]{"0","0","0"};//当前学年  学院   [教职工 总人数，行政类人数，教学类人数]
//      		teacherTypeNum = this.teacherPortalService.queryTeacherTypeNumAll(schyear,academyN,academyList);
//      		model.addAttribute("teacherTypeNum", teacherTypeNum);
      		//主页展示数据2        需要展示 当前学年 学院有多少
      		int StuNoAll=0;
      		StuNoAll=this.teacherPortalService.queryStuNoAll(schyear,academyN,academyList);
      		model.addAttribute("StuNoAll", StuNoAll);
      		//End
        
      	//获取用户菜单	
      	Map<String, List<MhMenu>>  map=iRoleManageService.getUserVisiableMenu(userId);
		String stat1="";
		String stat2="";
		if(map.get("optList")!=null && map.get("optList").size()>0){
	      	for(MhMenu mn:map.get("optList")){
	      		if("CONFIG".equals(mn.getMhMenuCode())){
	      			stat1="ok";
	      		}else if("PERMISSIONS".equals(mn.getMhMenuCode())){
	      			stat2="ok";
	      		}
	      	}
		}
		
		model.addAttribute("allMenu", map.get("allMenu"));//自定义配置菜单列表(只可显示权限内的菜单)
		model.addAttribute("menuList", map.get("viewList"));//可显示菜单列表
		model.addAttribute("configManage",stat1);//自定义配置按钮
		model.addAttribute("permManage",stat2);//权限管理按钮
		model.addAttribute("messageCount", mhMessageList.size());//总的消息条数
		model.addAttribute("messageUnReadCount", x);//未读消息条数
		model.addAttribute("mhInteract", mit);
		//model.addAttribute("mhNewslist", mhNewslist);
		model.addAttribute("userName", loginName);
		
		
		return "/home/newsManage/teacherIndex";
	}
	
	
	
	

    /**
	 * 评论页面
	 * */
	@RequestMapping("/menhu/opt-query/queryMessagesList" )
	public String queryMessagesList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId="";
		String mhSender="";
		String mhOwner="";
		int pageNo = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue()+1 : 1;
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String  teacherId=request.getParameter("teacherId");
		//System.out.println("评论页面==========teacherId========"+teacherId);
		int x=0;
		if(DataUtil.isNotNull(teacherId)){//从学生门户跳转过来
			userId=teacherId;
			mhOwner=teacherId;
			mhSender=sessionUtil.getCurrentUserId();
			model.addAttribute("teacherId", userId);//老师id
			model.addAttribute("teacherName", iRoleUserManageService.getUserById(userId).getName());//老师id
		}else{//从教师门户跳转过来
			x++;
			userId = sessionUtil.getCurrentUserId();
			mhSender=userId;
			teacherId=userId;
		}
		
		
		//我的评论列表
		List<MhMessage> myMessageList=iMessageService.getUserAllMessagesByMhSenderId(mhSender,teacherId);
		
		Map<String,Object> map=iMessageService.getMessagesPageByMhOwnerId(teacherId, pageNo);
		
		//全部评论列表
		List<MhMessage> allMessageList=(List<MhMessage>)map.get("allMessageList");
		
		
		
		if(x>0){
			//将评论状态设为已读
			iMessageService.updateMhMessageIsReadByIdList(allMessageList);
		}
		
		response.setCharacterEncoding("UTF-8");
		model.addAttribute("allMessageList", allMessageList);//全部评论
		model.addAttribute("myMessageList", myMessageList);//我的评论
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("allCount", map.get("allCount"));
		model.addAttribute("myCount", myMessageList==null?0:myMessageList.size());
		
		return "/home/newsManage/comment";
	}
	
	
	
	   /**
		 * 点击更多获取评论
		 * */
		@RequestMapping("/menhu/opt-query/queryMoreMessagesList" )
		public String queryMoreMessagesList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
			
			int pageNo = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue()+1: 1;
			
			String  teacherId=request.getParameter("teacherId");
			
			int x=0;
			
			if(DataUtil.isNull(teacherId)){
				x++;
				SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
				teacherId=sessionUtil.getCurrentUserId();
			}else{
				model.addAttribute("teacherId", "ok");
			}
			
			//全部评论列表(一页10条)
			List<MhMessage> messageList=(List<MhMessage>)iMessageService.getMessagesPageByMhOwnerId(teacherId, pageNo).get("allMessageList");
			
			if(x>0){
				//将评论设为已读
				iMessageService.updateMhMessageIsReadByIdList(messageList);
			}
			
			
			
			response.setCharacterEncoding("UTF-8");
			model.addAttribute("messageList", messageList);
			model.addAttribute("mystat", messageList!=null && messageList.size()>0?"ok":"no");
			return "/home/newsManage/moreComment";
		}
	
	
	
		/**
		 *给评论点赞
		 * */
		@RequestMapping("/menhu/opt-update/updateMessageZan" )
		public void updateMessageZan(ModelMap model,HttpSession session, HttpServletRequest request,HttpServletResponse response){
			
			String  messageId=request.getParameter("messageId");
			SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
			String userId=sessionUtil.getCurrentUserId();
			if(DataUtil.isNotNull(session.getAttribute(userId+messageId))){
				try {
					response.getWriter().println("error");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else{
				session.setAttribute(userId+messageId, "ok");
				
				MhMessage mhm=iMessageService.getMhMessageListById(messageId);
				mhm.setMhZan(mhm.getMhZan()+1);
				iMessageService.saveMhMessage(mhm);
				
				try {
					response.getWriter().println("ok");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		}
	
	
	/**
	 *提交回复评论
	 * */
	@RequestMapping("/menhu/opt-add/addMessageReceive" )
	public String addMessageReceive(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String  content=request.getParameter("content");
		String  messageId=request.getParameter("messageId");
		String  teacherId=request.getParameter("teacherId");
		
		try {
			content=new String(content.getBytes("ISO8859-1"),"UTF-8");
		}catch (Exception e) {
				/*e.printStackTrace();*/
		}

		
		
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String mhSender=sessionUtil.getCurrentUserId();
		User user=new User();
		user.setId(mhSender);
		
		MhMessage me=iMessageService.getMhMessageListById(messageId);
		MhMessage mhm=new MhMessage();
		mhm.setMhContent(content);
		mhm.setMhIsread(iDicManageService.getMhDicByParentCodeOrId("UNREAD", ""));
		mhm.setMhOwner(me.getMhOwner());
		mhm.setMhSender(user);
		mhm.setMhParentId(messageId);
		mhm.setMhZan(0);
		mhm.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
		
		iMessageService.saveMhMessage(mhm);
		
		return "redirect:/menhu/opt-query/queryMessagesList.do?teacherId="+teacherId;
	}
	
	
	/**
	 *提交评论
	 * */
	@RequestMapping("/menhu/opt-add/addMessageComments" )
	public String addMessageComments(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		try {
			request.setCharacterEncoding("UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String  content=request.getParameter("content");
		String  teacherId=request.getParameter("teacherId");
		
		
		try {
			content=new String(content.getBytes("ISO8859-1"),"UTF-8");
		}catch (Exception e) {
				/*e.printStackTrace();*/
		}
		
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String mhSender=sessionUtil.getCurrentUserId();
		User user=new User();
		user.setId(mhSender);
		User user01=new User();
		user01.setId(teacherId);
		
		MhMessage mhm=new MhMessage();
		mhm.setMhContent(content);
		mhm.setMhIsread(iDicManageService.getMhDicByParentCodeOrId("UNREAD", ""));
		mhm.setMhOwner(user01);
		mhm.setMhSender(user);
		mhm.setMhZan(0);
		mhm.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
		
		iMessageService.saveMhMessage(mhm);
		
		return "redirect:/menhu/opt-query/queryMessagesList.do?teacherId="+teacherId;
	}
	
	
	
	/**
	 *保存用户菜单自定义配置
	 * */
	@RequestMapping("/menhu/opt-save/saveMenusConfig" )
	public void saveMenusConfig(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String  content=request.getParameter("content");
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId=sessionUtil.getCurrentUserId();
		MhConfig mc=iConfigManageService.getMhConfigByUserId(userId);
		
		if(mc!=null && DataUtil.isNotNull(mc.getId())){
			mc.setMhMenus(content);
			iConfigManageService.saveMhConfig(mc);
		}else{
			User user=new User();
			user.setId(userId);
			MhConfig mc01=new MhConfig();
			mc01.setMhMenus(content);
			mc01.setMhUserid(user);
			mc01.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
			iConfigManageService.saveMhConfig(mc01);
		}
		
		try {
			response.getWriter().println("ok");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 *学生门户给老师点鲜花和点鸡蛋(学生门户参与人数问题解决方案：增加一个与教学互动表相关联的表，每点赞一次就新增一条记录)
	 * */
	@RequestMapping("/menhu/opt-add/updateMhInteract" )
	public void updateMhInteract(ModelMap model,HttpSession session, HttpServletRequest request,HttpServletResponse response){
		String  teacherId=request.getParameter("teacherId");
		String  flag=request.getParameter("flag");
		
		if(DataUtil.isNotNull(session.getAttribute(teacherId+flag))){
			
			try {
				response.getWriter().println("error");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else{
		   
			MhInteract mi=iInteractService.getInteractByUserId(teacherId);
			if(mi!=null && DataUtil.isNotNull(mi.getId())){
				if("flower".equals(flag)){
					mi.setMhFlower(mi.getMhFlower()+1);
				}else if("egg".equals(flag)){
					mi.setMhEgg(mi.getMhEgg()+1);
				}
				iInteractService.saveInteract(mi);
			}else{
				MhInteract mi01=new MhInteract();
				if("flower".equals(flag)){
					mi01.setMhFlower(1);
				}else if("egg".equals(flag)){
					mi01.setMhEgg(1);
				}
				User user=new User();
				user.setId(teacherId);
				mi01.setMhUserid(user);
				iInteractService.saveInteract(mi01);
			}
			session.setAttribute(teacherId+flag, "zan");
			try {
				response.getWriter().println("ok");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	
	/**
	 *删除评论
	 * */
	@RequestMapping("/menhu/opt-del/deleteMhMessage" )
	public String deleteMhMessage(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		
		String  messageId=request.getParameter("messageId");
		String  teacherId=request.getParameter("teacherId");
		String  sta=request.getParameter("sta");
	    if(DataUtil.isNotNull(sta) && "A".equals(sta) ){//删除一级评论及其子评论
	    	iMessageService.deleteMhMessageByMhParentId(messageId);
	    	
	    }else if(DataUtil.isNotNull(sta) && "B".equals(sta)){//删除二级评论
	    	iMessageService.deleteMhMessageById(messageId);
	    }
		
		return "redirect:/menhu/opt-query/queryMessagesList.do?teacherId="+teacherId;
	}
	
	
	/**
	 *修改用户密码
	 * */
	@RequestMapping("/menhu/opt-upt/updateUserPassword" )
	@ResponseBody
	public String updateUserPassword(HttpServletRequest request,HttpServletResponse response){
		try{
			SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
			String userId=sessionUtil.getCurrentUserId();
			iRoleUserManageService.updateUserPassword(userId);
		}catch(Exception e){
			System.out.println("用户密码修改失败！");
			return "error";
		}
		
	    return "success";	
	}
	
	
}
