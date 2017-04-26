package com.uws.home.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.uws.core.base.BaseController;
import com.uws.core.session.SessionFactory;
import com.uws.core.session.SessionUtil;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.StudentPortalService;
/** 
* @Description:学生的门户控制层
*/
@Controller
public class StudentPortalController extends BaseController{
	@Autowired
	public StudentPortalService  studentPortalService;
	@Autowired
	private INewsManageService iNewsManageService;
	/** 准备 进入学生门户* */
	@RequestMapping("/studentPortal/opt-query/studentPortalShow")
	public String studentPortalShow(ModelMap model,HttpServletRequest request){
		MhStuUser StuUser=new MhStuUser();
		String[] PingTeaIds=new String[]{};
		String[] PingTeaNames=new String[]{};
		if(request.getSession().getAttribute("StuUser")==null &&
			request.getSession().getAttribute("PingTeaIds")==null &&
			request.getSession().getAttribute("PingTeaNames")==null ){
			//登录时间  获得学年信息
			SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
	        String userId    = sessionUtil.getCurrentUserId();//用户 UserId		
			StuUser=this.studentPortalService.getMhStuUser(userId);//只有 userId 和 姓名   身份证信息  所在学院
			request.getSession().setAttribute("StuUser", StuUser);
			//封装一个与用户有关系的 教师 ID list 提供评价 session级别
			List<String[]> PingTea=this.studentPortalService.getMhStuRelatedTea(StuUser);
			if(PingTea.size()==2 && PingTea.get(0).length==PingTea.get(1).length){
				PingTeaIds=PingTea.get(0);  	PingTeaNames=PingTea.get(1);
			}
			request.getSession().setAttribute("PingTeaIds", PingTeaIds);
			request.getSession().setAttribute("PingTeaNames", PingTeaNames);		
		}else{
			StuUser=(MhStuUser) request.getSession().getAttribute("StuUser");
			PingTeaIds=(String[]) request.getSession().getAttribute("PingTeaIds");
			PingTeaNames=(String[]) request.getSession().getAttribute("PingTeaNames");
		}
		//展示当前默认第一个教师姓名 以及  userId
		model.addAttribute("PingTeaName", PingTeaNames.length>0?PingTeaNames[0]:"");
		model.addAttribute("PingTeaId",   PingTeaIds.length>0?  PingTeaIds[0]:"");
		//完成功能面板上的参数   本学期已缴
		String haspadfee=this.studentPortalService.getMhStuCurrentFee(StuUser.getSFZH(),StuUser.getBMMC());
		model.addAttribute("haspadfee", haspadfee);	
		//对接 加载新闻板块 [新闻功能作废]
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
		}
		model.addAttribute("mhNewslist", mhNewslist);*/
		//完成功能面板参数 未签到
		String notsign=this.studentPortalService.getMhStuNotSign(StuUser.getSFZH());
		model.addAttribute("notsign", notsign);
		return "/home/student/studentPortalShow";
	}
	/**
	 * 进入 详情展示页面 的框架页面
	 * */
	@RequestMapping("/studentPortal/opt-query/studentDetailsFrame")
	public String studentDetailsFrame(ModelMap model,HttpServletRequest request,String menuParam){	
		model.addAttribute("menuParam", menuParam);//激活的菜单码
		return "/home/student/studentDetailsFrame";
	}
	/**
	 * 进入 学生【学费收缴详情】页面
	 * */
	@RequestMapping("/studentPortal/opt-query/studentTuitionShow")
	public String studentTuitionShow(ModelMap model,HttpServletRequest request){
		MhStuUser StuUser=(MhStuUser) request.getSession().getAttribute("StuUser");
		List<MhStuUserTuition> TuitionList=this.studentPortalService.getMhStuTuitionDetails(StuUser);
		model.addAttribute("TuitionList", TuitionList);
		return "/home/student/studentTuitionShow";
	}
	/**
	 * 互动模块  查询  上一个 老师的Ajax 操作
	 * */
	@RequestMapping("/studentPortal/opt-query/getPreTeacher")
	public void getPreTeacher(ModelMap model,HttpServletRequest request,HttpServletResponse response){
		String teaid=request.getParameter("teaNameNow");//实际上传的是id
		JSONObject jsonObj  = new JSONObject();
		String tID="",tName="";
		if(teaid!=null && !"".equals(teaid)){
			if(request.getSession().getAttribute("PingTeaIds")!=null &&
					request.getSession().getAttribute("PingTeaNames")!=null ){
				String[] PingTeaIds=(String[]) request.getSession().getAttribute("PingTeaIds");
				String[] PingTeaNames=(String[]) request.getSession().getAttribute("PingTeaNames");
				if(PingTeaIds.length==PingTeaNames.length && PingTeaNames.length!=0 ){
					int size=PingTeaIds.length;
					for (int i = 0; i < PingTeaIds.length; i++) {
						if(teaid.equals(PingTeaIds[i])){//找到了
							int k=i-1;
							if(k<=-1){k=size-1;}
							jsonObj.put("tID", PingTeaIds[k]);
							jsonObj.put("tName", PingTeaNames[k]);
						}
					}
					JSONObject json = JSONObject.fromObject(jsonObj);
					response.setCharacterEncoding("UTF-8");
					try {response.getWriter().print(json);
					}catch (IOException e) {/*e.printStackTrace();System.out.println("MHCODE001");*/}
				}
			}
		}
	}
	/**
	 * 互动模块   查询  下一个 老师的Ajax 操作
	 * */
	@RequestMapping("/studentPortal/opt-query/getNextTeacher")
	@ResponseBody
	public void getNextTeacher(ModelMap model,HttpServletRequest request,HttpServletResponse response){
		String teaid=request.getParameter("teaNameNow");//实际上传的是id
		JSONObject jsonObj  = new JSONObject();
		String tID="",tName="";
		if(teaid!=null && !"".equals(teaid)){
			if(request.getSession().getAttribute("PingTeaIds")!=null &&
					request.getSession().getAttribute("PingTeaNames")!=null ){
				String[] PingTeaIds=(String[]) request.getSession().getAttribute("PingTeaIds");
				String[] PingTeaNames=(String[]) request.getSession().getAttribute("PingTeaNames");
				if(PingTeaIds.length==PingTeaNames.length && PingTeaNames.length!=0 ){
					int size=PingTeaIds.length;
					for (int i = 0; i < PingTeaIds.length; i++) {
						if(teaid.equals(PingTeaIds[i])){//找到了
							int k=i+1;
							if(k==size){k=0;}
							jsonObj.put("tID", PingTeaIds[k]);
							jsonObj.put("tName", PingTeaNames[k]);
						}
					}
					JSONObject json = JSONObject.fromObject(jsonObj);
					response.setCharacterEncoding("UTF-8");
					try {response.getWriter().print(json);
					}catch (IOException e) {/*e.printStackTrace();System.out.println("MHCODE002");*/}
				}
			}
		}
	}
}
