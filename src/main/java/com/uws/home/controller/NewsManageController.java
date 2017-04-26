package com.uws.home.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

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
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
import com.uws.home.model.MhNewsDTO;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.INewsManageService;
import com.uws.home.service.IRoleManageService;
import com.uws.home.service.IRoleUserManageService;
import com.uws.sys.model.Dic;
import com.uws.user.model.User;

/**
 * @ClassName    NewsManageController
 * @Description  门户新闻信息controller
 * @author       何进
 * @date         2016-8-19下午14:39:22
 */
@Controller
public class NewsManageController {
      
	@Autowired
	private IRoleManageService iRoleManageService;
	
	@Autowired
	private INewsManageService iNewsManageService;
	
	@Autowired
	private IDicManageService iDicManageService;
	
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
	 * 门户新闻信息列表
	 * */
	@RequestMapping("/menhu/opt-query/queryNewsList" )
	public String queryNewsList(ModelMap model,String search,String typeId, HttpSession sessionUtil,HttpServletRequest request,HttpServletResponse response){
		int pageNo = request.getParameter("pageNo") != null ? Integer.valueOf(request.getParameter("pageNo")).intValue()+1 : 1;
		
		//获取查询记录
	    String flag = request.getParameter("flag");
		if(DataUtil.isNotNull(flag) && flag.equals("1")){
			String search01 = (String)sessionUtil.getAttribute("search");
			String typeId01 = (String)sessionUtil.getAttribute("typeId");
			 if(DataUtil.isNotNull(search01))
				 search = search01;
			 if(DataUtil.isNotNull(typeId01))
				 typeId = typeId01;
	    }
		
		SessionUtil session = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId = session.getCurrentUserId();
		Map<String, List<MhMenu>>  map=iRoleManageService.getUserVisiableMenu(userId);
		String stat1="";
		String stat2="";
		String stat3="";
		if(map.get("optList")!=null && map.get("optList").size()>0){
	      	for(MhMenu mn:map.get("optList")){
	      		if("NEWS_MANAGE".equals(mn.getMhMenuCode())){
	      			stat1="ok";
	      			stat2="ok";
	      			stat3="ok";
	      		}
	      	}
		}
		
		List<MhDic> newsTypeList=iDicManageService.getMhDicListByParentCode("NEWS_TYPE");//获取新闻类别列表
		
		//保存查询记录
		sessionUtil.setAttribute("search", search);
	    sessionUtil.setAttribute("typeId", typeId);
		Page page =iNewsManageService.queryNewsList(search, typeId, pageNo);
	
		
		model.addAttribute("newsTypeList", newsTypeList);
		//列表分页数据
		model.addAttribute("page", page);
		model.addAttribute("publish_news", stat1);
		model.addAttribute("delete_news", stat2);
		model.addAttribute("caogao", stat3);
		model.addAttribute("search", search);
		model.addAttribute("pageNo", pageNo);
		
		
		return "/home/newsManage/newsList";
	}
	
	
	/**
	 * 点击更多获取新闻信息列表
	 * */
	@RequestMapping("/menhu/opt-query/queryMoreNewsList" )
	public void queryMoreNewsList(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		String  search=request.getParameter("search");
		String  typeId=request.getParameter("typeId");
		String  pageNo01=request.getParameter("pageNo");
		int pageNo=Integer.valueOf(pageNo01)+1;
		List<MhNews> moreNews=(List<MhNews>)iNewsManageService.queryNewsList(search, typeId, pageNo).getResult();
	    List<MhNewsDTO> newList=new ArrayList();
	    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    if(moreNews!=null && moreNews.size()>0){
			for(MhNews ms:moreNews){
				MhNewsDTO mn=new MhNewsDTO();
				mn.setMhNewsContent(ms.getMhNewsContent());
				mn.setMhNewsTitle(ms.getMhNewsTitle());
				mn.setMhNewsTypeId(ms.getMhNewsType().getMhCode());//新闻类型编码
				mn.setMhNewsTypeCode(ms.getMhNewsType().getId());//新闻类型id
				mn.setMhNewsTypeName(ms.getMhNewsType().getMhName());
				mn.setMhPublisher(ms.getMhPublisher());
				mn.setNewTime(format.format(ms.getUpdateTime()));
				mn.setId(ms.getId());//传id
				//设置是否已发布标识符
				if(DataUtil.isNotNull(ms.getStatus().getMhCode())){
					if("PUBLISHED".equals(ms.getStatus().getMhCode())){
						mn.setStatus("ok");
					}else if("UNPUBLISHED".equals(ms.getStatus().getMhCode())){
						mn.setStatus("no");
					}
				}
				
				newList.add(mn);
			}
	    }
	    
		
		
		
		JSONObject jsonObj  = new JSONObject();
		if(newList!=null && newList.size()>0){
            jsonObj.put("result", newList);
		}else{
			jsonObj.put("result", "no");
		}
        jsonObj.put("pageNo", pageNo);
		JSONObject json = JSONObject.fromObject(jsonObj);
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(json);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	
	/**
	 * 教师门户新闻详细信息
	 * */
	@RequestMapping("/menhu/opt-query/queryNewsDetail" )
	public String queryNewsDetail(ModelMap model, HttpServletRequest request,HttpSession session,HttpServletResponse response){
		String  mhNewsId=request.getParameter("mhNewsId");
		String  typeId=request.getParameter("typeId");
		//用于标识是从哪个位置进入详情页面的
		String  newStat=request.getParameter("newStat");
		MhNews mns=this.iNewsManageService.queryNewsById(mhNewsId);
		
		if("A".equals(newStat)){
			typeId="";
		}
		
		List<MhNews> twoNews=this.iNewsManageService.queryTwoMhNews(mhNewsId,mns,typeId);
		
		model.addAttribute("newStat", newStat);
		model.addAttribute("newsInfo", mns);
		model.addAttribute("twoNews", twoNews);
		return "/home/newsManage/newsDetail";
	}
	
	/**
	 * 删除一条新闻信息
	 * */
	@RequestMapping("/menhu/opt-del/deleteNews" )
	public void deleteNews(HttpServletRequest request,HttpServletResponse response){
		String  mhNewsId=request.getParameter("mhNewsId");
		String  stat=request.getParameter("stat");
		if(DataUtil.isNotNull(stat)&&"del_a".equals(stat)){//删除已发布的，逻辑删除
			MhNews mns=this.iNewsManageService.queryNewsById(mhNewsId);
			MhDic mc=iDicManageService.getMhDicByParentCodeOrId("DELETED", "");//表示已删除的
			mns.setDeleteStatus(mc);
			iNewsManageService.addNews(mns);
		}else if(DataUtil.isNotNull(stat)&&"del_b".equals(stat)){//删除草稿，物理删除
			MhNews mns=this.iNewsManageService.queryNewsById(mhNewsId);
			iNewsManageService.delMhNews(mns);
			
		}
		
	
		try {
			response.getWriter().println("ok");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 新增或修改新闻信息
	 * */
	@RequestMapping("/menhu/opt-add/addNewsView" )
	public String addNewsView(ModelMap model, HttpServletRequest request,HttpServletResponse response){
		List<MhDic> newsTypeList=iDicManageService.getMhDicListByParentCode("NEWS_TYPE");//获取新闻类别列表
		String  mhNewsId=request.getParameter("mhNewsId");
		
		
		
		if(DataUtil.isNotNull(mhNewsId)){
			MhNews mns=this.iNewsManageService.queryNewsById(mhNewsId);
			model.addAttribute("mhNews", mns);
		}else{
			SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
			String userId = sessionUtil.getCurrentUserId();
			
			MhNews mns=new MhNews();
			mns.setMhPublisher(iRoleUserManageService.getUserById(userId).getName());
			model.addAttribute("mhNews", mns);
		}
		
		
		model.addAttribute("newsTypeList", newsTypeList);
		
		return "/home/newsManage/newsPublish";
	}
	
	
	/**
	 * 保存新闻信息
	 * */
	@RequestMapping("/menhu/opt-save/saveNews" )
	public String saveNews(MhNews mhNews, HttpServletRequest request,HttpServletResponse response){
		String  sts=request.getParameter("sts");
		String  pubs=request.getParameter("pubs");
		String  mhNewsId=request.getParameter("mhNewsId");
		
		SessionUtil sessionUtil = SessionFactory.getSession(com.uws.sys.util.Constants.MENUKEY_SYSCONFIG);
		String userId = sessionUtil.getCurrentUserId();
	     User creator=new User();
	     creator.setId(userId);
	     mhNews.setMhCreator(creator);
	    
	     
	     if(DataUtil.isNotNull(sts)&&"saves".equals(sts)){//保存
	    	 if(DataUtil.isNotNull(mhNews.getId())){
	    		 MhNews mn=this.iNewsManageService.queryNewsById(mhNews.getId());
	    		 mn.setMhNewsContent(mhNews.getMhNewsContent());
                 mn.setMhNewsTitle(mhNews.getMhNewsTitle());
                 mn.setMhNewsType(mhNews.getMhNewsType());
                 mn.setMhPublisher(mhNews.getMhPublisher());
                 mn.setStatus(iDicManageService.getMhDicByParentCodeOrId("UNPUBLISHED", ""));
                 iNewsManageService.addNews(mn);
	    	 }else{
	    		 mhNews.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
	    		 mhNews.setStatus(iDicManageService.getMhDicByParentCodeOrId("UNPUBLISHED", ""));
	    		 iNewsManageService.addNews(mhNews);
	    	 }
	     }else{
	    	 if(DataUtil.isNotNull(mhNews.getId())){
	    		 MhNews mn=this.iNewsManageService.queryNewsById(mhNews.getId());
	    		 mn.setMhNewsContent(mhNews.getMhNewsContent());
                 mn.setMhNewsTitle(mhNews.getMhNewsTitle());
                 mn.setMhNewsType(mhNews.getMhNewsType());
                 mn.setMhPublisher(mhNews.getMhPublisher());
                 mn.setStatus(iDicManageService.getMhDicByParentCodeOrId("PUBLISHED", ""));
                 iNewsManageService.addNews(mn);
	    	 }else if(DataUtil.isNotNull(pubs)){
	    		 MhNews mn=this.iNewsManageService.queryNewsById(mhNewsId);
	    		 mn.setStatus(iDicManageService.getMhDicByParentCodeOrId("PUBLISHED", ""));
	    		 iNewsManageService.addNews(mn);
	    	 }else{
	    		 mhNews.setDeleteStatus(iDicManageService.getMhDicByParentCodeOrId("NORMAL", ""));
	    		 mhNews.setStatus(iDicManageService.getMhDicByParentCodeOrId("PUBLISHED", ""));
	    		 iNewsManageService.addNews(mhNews);
	    	 }
	     }
	     
	     
	     return "redirect:/menhu/opt-query/queryNewsList.do";
        /* JSONObject jsonObj  = new JSONObject();
         jsonObj.put("result", "ok");
		 JSONObject json = JSONObject.fromObject(jsonObj);
		 response.setCharacterEncoding("UTF-8");
		 try {
			 response.getWriter().print(json);
		 } catch (IOException e) {
			e.printStackTrace();
		 } */   
	}
	
	
}
