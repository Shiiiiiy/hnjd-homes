package com.uws.home.service.impl;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.service.INewsManageService;

/**
 * @ClassName    NewsManageServiceImpl
 * @Description  门户新闻管理接口实现类
 * @author             联合永道
 * @date         2016-08-25下午16:14:22
 */
@Service("NewsManageServiceImpl")
public class NewsManageServiceImpl extends BaseServiceImpl implements INewsManageService{
	@Autowired
	private INewsManageDao iNewsManageDao;
	@Autowired
	private IDicManageDao iDicManageDao;
	
	@Override  
	public Page queryNewsList(String search,String typeId,int pageNo){
		MhDic mc=new MhDic();
		if("caogao".equals(typeId)){
				mc=iDicManageDao.getMhDicByParentCodeOrId("UNPUBLISHED", "");
		}else{
				mc=iDicManageDao.getMhDicByParentCodeOrId("PUBLISHED", "");
		}
		
		return iNewsManageDao.queryNewsList(search, typeId, pageNo,iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""),mc);
	}
	
	@Override
	public void addNews(MhNews mhNews){
		this.iNewsManageDao.addNews(mhNews);
	}
	
	@Override
	public MhNews queryNewsById(String mhNewsId){
		
		return this.iNewsManageDao.queryNewsById(mhNewsId) ;
	}
	
	@Override
	public List<MhNews> queryTwoMhNews(String mhNewsId,MhNews ms,String typeId){
		List<MhNews> list=new ArrayList();
		if(DataUtil.isNotNull(typeId) && "PUBLISHED".equals(ms.getStatus().getMhCode())){
			list=this.iNewsManageDao.queryAllNewsList(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""),typeId,ms.getStatus());
		}else if(DataUtil.isNull(typeId)){
			list=this.iNewsManageDao.queryAllNewsList(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""),null,ms.getStatus());
		}else if(DataUtil.isNotNull(typeId) && "UNPUBLISHED".equals(ms.getStatus().getMhCode())){
			list=this.iNewsManageDao.queryAllNewsList(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""),null,ms.getStatus());
		}
		
		List<MhNews> list01=new ArrayList();
		
		for(int i=0;i<list.size();i++){
			if(mhNewsId.equals(list.get(i).getId())){
				if(i==0){
					list01.add(new MhNews());
					list01.add(list.size()>1?list.get(1):new MhNews());					
				}else if(i>0 && i==list.size()-1){					
					list01.add(list.get(list.size()-2));
					list01.add(new MhNews());				
				}else{
					list01.add(list.get(i-1));
					list01.add(list.get(i+1));
				}
			}
		}
		
		return list01;
	}
	
	@Override
	public void delMhNews(MhNews mhNews){
		
		iNewsManageDao.delMhNews(mhNews);
	}
	
}
