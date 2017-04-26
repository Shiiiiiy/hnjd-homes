package com.uws.home.controller;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.uws.core.base.BaseController;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.session.SessionFactory;
import com.uws.core.session.SessionUtil;
import com.uws.core.util.DataUtil;
import com.uws.home.model.MHstatistStudentTuition;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhTeacherUser;
import com.uws.home.service.IRoleManageService;
import com.uws.home.service.StudentPortalService;
import com.uws.home.service.TeacherPortalService;
/** 
* @Description:教师的门户控制层
*/
@Controller
public class TeacherPortalController extends BaseController{
	/**
	 * 准备 进入教师门户
	 * */
	@Autowired
	public TeacherPortalService  teacherPortalService;
	@Autowired
	private IRoleManageService iRoleManageService;
	/**
	 * 【学生缴费详情】统计页面  财务库  
	 * */
	@RequestMapping("/teacherPortal/opt-query/statistStudentTuition")
	public String statistStudentTuition(ModelMap model,HttpServletRequest request,String schyear,String academyN){
		//判断是进入条形页面 还是宫格页面
		String default_on=request.getParameter("default_on");
		if(null==default_on || "".equals(default_on)){default_on="square";}
		model.addAttribute("default_on", default_on);//需要展示的 可选学年列表 bdp
		//
		List<String> schyearList=(List<String>) request.getSession().getAttribute("schyearList");
		List<String> academyList=(List<String>) request.getSession().getAttribute("academyList");		
		MhTeacherUser TeaUser=(MhTeacherUser) request.getSession().getAttribute("TeaUser");
		//schyear academyN的值初始化
		if(schyear==""||schyear==null){ schyear=TeaUser.getNowYear();      }
		if(academyN==""||academyN==null){ if(academyList.size()>=1){academyN=academyList.get(0);}else{academyN="";}		}
		//以学院为单位  饼图走财务  建立实体类 全部String
		List<MHstatistStudentTuition> MHstuFeeList=new ArrayList<MHstatistStudentTuition>();
		//List [院系名称,总人数,完全缴,未缴,部分缴,缴费状态]
		MHstuFeeList=this.teacherPortalService.queryMHstuFeeList(schyear,academyN,MHstuFeeList,academyList);
		//追加查询  [国家助学贷款  一般助学贷款  商业性教育助学贷款  个人教育助学贷款 学校无息贷款]
		//MHstuFeeList=this.teacherPortalService.queryMHstuFeeList2(schyear,academyN,MHstuFeeList,academyList);
		model.addAttribute("MHstuFeeList", MHstuFeeList);
		//无视学院条件  所有学院汇总表 
		MHstatistStudentTuition MHstuFeeListAll=new MHstatistStudentTuition();
		MHstuFeeListAll=this.teacherPortalService.queryMHstuFeeListAll(MHstuFeeList);//汇总计算
		model.addAttribute("MHstuFeeListAll", MHstuFeeListAll);
		//基础参数保存
		model.addAttribute("schyear", schyear);
		model.addAttribute("academyN", academyN);	
		return "/home/teacher/statistStudentTuition";
	}
	/**
	 * 【学生信息详情】统计页面   财务库  基础平台 
	 * */
	@RequestMapping("/teacherPortal/opt-query/statistStudentInfo")
	public String statistStudentInfo(ModelMap model,HttpServletRequest request,String schyear,String academyN){
		List<String> schyearList=(List<String>) request.getSession().getAttribute("schyearList");
		List<String> academyList=(List<String>) request.getSession().getAttribute("academyList");		
		MhTeacherUser TeaUser=(MhTeacherUser) request.getSession().getAttribute("TeaUser");
		//schyear academyN的值初始化
		if(schyear==""||schyear==null){ schyear=TeaUser.getNowYear();      }
		if(academyN==""||academyN==null){ if(academyList.size()>=1){academyN=academyList.get(0);}else{academyN="";}		}
		///三届 各院人数值 院系名称数组 [,,,,]
		int size = academyList.size();  
		String[] academyNames = (String[])academyList.toArray(new String[size]);
		model.addAttribute("academyNames", academyNames);	
		//[year-1 ,,,,]   [year   ,,,,]   [year-1 ,,,,]
		List<String[]> listforbar=this.teacherPortalService.queryListforbar(schyear,schyearList,academyList);
		if(listforbar!=null && listforbar.size()!=0 && listforbar.size()==3){
			model.addAttribute("bar1", listforbar.get(0));
			model.addAttribute("bar2", listforbar.get(1));
			model.addAttribute("bar3", listforbar.get(2));
			int teh=listforbar.get(0).length;
			model.addAttribute("baryear",new String[]{listforbar.get(0)[teh-1],listforbar.get(1)[teh-1],listforbar.get(2)[teh-1]});
		}
		//指定院系 [年-1，年，年+1，值，值，值]
		String[] listforline=this.teacherPortalService.queryListforline(schyear,schyearList,academyN);
		model.addAttribute("listforline", listforline);
		//在校生人数 调用函数即可
		int StuNoAll=this.teacherPortalService.queryStuNoAll(schyear,academyN,academyList);
		model.addAttribute("StuNoAll", StuNoAll);//单一值 在校人数 指定年去重复
		//男女比 [男  男比  女  女比]比例为 百分制 入学学年
		String[] stusexrate=new String[4];
		stusexrate = this.teacherPortalService.queryStuSexRate(schyear,academyN);
		model.addAttribute("stusexrate", stusexrate);
		//招生方式  [统招  统招比  自考  自考比]
		String[] enrollment=new String[4];
		enrollment = this.teacherPortalService.queryStuEnrollment(schyear,academyN);
		model.addAttribute("enrollment", enrollment);
		//生源地  [河南  其他]
		String[] shenyuandi=new String[2];
		shenyuandi = this.teacherPortalService.queryStuOriginPlace(schyear,academyN);
		model.addAttribute("shenyuandi", shenyuandi);
		//调用服务获取数据
		model.addAttribute("schyear", schyear);
		model.addAttribute("academyN", academyN);	
		return "/home/teacher/statistStudentInfo";
	}
	/**
	 * 【教职工信息详情】统计页面    基础平台 
	 * */
	@RequestMapping("/teacherPortal/opt-query/statistTeacherInfo")
	public String statistTeacherInfo(ModelMap model,HttpServletRequest request,String schyear,String academyN){
		//页面学年学院 数值 传递 初始化
		List<String> schyearList=(List<String>) request.getSession().getAttribute("schyearList");
		List<String> academyList=(List<String>) request.getSession().getAttribute("academyList");		
		MhTeacherUser TeaUser=(MhTeacherUser) request.getSession().getAttribute("TeaUser");
		//schyear academyN的值初始化
		if(schyear==""||schyear==null){ schyear=TeaUser.getNowYear();      }
		if(academyN==""||academyN==null){ if(academyList.size()>=1){academyN=academyList.get(0);}else{academyN="";}		}
		//当前学年  各学院   [教职工总人数柱状图]
		List<String[]> teacherNumBar=this.teacherPortalService.queryTeacherNumBar(schyear, academyList);
		if(teacherNumBar!=null&&teacherNumBar.size()==2){
			model.addAttribute("tOrgName", teacherNumBar.get(0));
			model.addAttribute("tTeaNum", teacherNumBar.get(1));
			int tTeaNumAll=0;
			for (int i = 0; i < teacherNumBar.get(1).length; i++) {
				try{tTeaNumAll+=Integer.parseInt(teacherNumBar.get(1)[i]);}
				catch(Exception e){/**/}
			}
			model.addAttribute("tTeaNumAll", tTeaNumAll);
		}
		//当前学年X  学院   [教职工男性人数，比重， 女性人数，比重]	
		String[] teacherSexNum=new String[4];
		teacherSexNum  = this.teacherPortalService.queryTeacherSexNum(schyear,academyN);
		model.addAttribute("teacherSexNum", teacherSexNum);
		//当前学年X  学院   年龄段人数[-30,30-35,35-40,40-45,45-50,50-55,55+ ] 规定集合 开 闭集 模式 
		String[] teacherAgeNum=new String[7];
		teacherAgeNum  = this.teacherPortalService.queryTeacherAgeNum(schyear,academyN);
		model.addAttribute("AgeNum", teacherAgeNum);
		//工作年限  当前学年X  学院  ["3年以下", "3-5年", "5-10年", "10-20年", "20-50年", "50年以上"]
		String[] teacherWorkYear=new String[6];
		teacherWorkYear  = this.teacherPortalService.queryTeacherWorkYearNum(schyear,academyN);
		model.addAttribute("WorkYear", teacherWorkYear);
		//将原始输入值返回页面
		model.addAttribute("schyear", schyear);
		model.addAttribute("academyN", academyN);
		return "/home/teacher/statistTeacherInfo";
	}
	/**
	 * 进入 详情展示页面 的【框架页面】
	 * */
	@RequestMapping("/teacherPortal/opt-query/teacherDetailsFrame")
	public String teacherDetailsFrame(ModelMap model,HttpServletRequest request,String menuParam){
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId = sessionUtil.getCurrentUserId();
		//可以展示的菜单权限
		Map<String, List<MhMenu>>  map=iRoleManageService.getUserVisiableMenu(userId);
		if(map.containsKey("viewList")){
			List<String> canview=new ArrayList<String>();
			try{
			List<MhMenu> list=map.get("viewList");
			for (int i = 0; i < list.size(); i++) {
				try{
					canview.add(list.get(i).getMhMenuName());
				}catch(Exception e){}
			}	
			}catch(Exception e){}
			model.addAttribute("canview", canview);//需要激活的菜单编号
		}
		model.addAttribute("menuParam", menuParam);//需要激活的菜单编号
		return "/home/teacher/teacherDetailsFrame";
	}
	//旧方法//
	@RequestMapping("/teacherPortal/opt-query/teacherPortalShow")
	public String teacherPortalShow(ModelMap model,HttpServletRequest request){
		//此方法 已经通过  menhu/opt-query/queryMenhuNewsList.do 实现 
		return "/home/teacher/teacherPortalShow";
	}
}