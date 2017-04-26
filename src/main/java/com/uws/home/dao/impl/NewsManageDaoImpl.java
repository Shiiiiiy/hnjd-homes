package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * 门户新闻管理实现类
 * @author hejin
 *
 */
@Repository("NewsManageDaoImpl")
public class NewsManageDaoImpl extends BaseDaoImpl implements INewsManageDao{

	
	
	@Override  
	public Page queryNewsList(String search,String typeId,int pageNo,MhDic mhDic,MhDic mhDic01){
		StringBuffer hql=new StringBuffer("select news from MhNews news where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(search)){
			hql.append(" and (news.mhNewsTitle like ? or news.mhNewsContent like ?) ");
			values.add("%"+search+"%");
			values.add("%"+search+"%");
		}
		
		if(DataUtil.isNotNull(typeId) ){
				if("caogao".equals(typeId)){
					hql.append(" and news.status=? ");
					values.add(mhDic01);
				}else{
					hql.append(" and news.mhNewsType.id=? and news.status=? ");
					values.add(typeId);
					values.add(mhDic01);
				}
		}else{
				hql.append(" and news.status=? ");
				values.add(mhDic01);
		}
		
		
		if(DataUtil.isNotNull(mhDic)){
			hql.append(" and news.deleteStatus=? ");
			values.add(mhDic);
		}
		
		hql.append(" order by news.updateTime desc ");
		if (values.size() == 0){
			return this.pagedQuery(hql.toString(), pageNo, 10);
		}else{
			return this.pagedQuery(hql.toString(),pageNo, 10,values.toArray() );
		} 
	}
	
	
	
	@Override
	public void addNews(MhNews mhNews){
		this.save(mhNews);
	}
	
	@Override
	public MhNews queryNewsById(String mhNewsId){
	    if(DataUtil.isNotNull(mhNewsId)){
	    	return (MhNews)this.get(MhNews.class, mhNewsId);
	    }else{
	    	return null;
	    }
		
	}
	
	@Override
	public List<MhNews> queryAllNewsList(MhDic mhDic,String typeId,MhDic mc){
		StringBuffer hql=new StringBuffer(" select news from MhNews news where 1=1  ");
		List<Object> values=new ArrayList();
		
		System.out.println("typeId====="+typeId);
		
		if(DataUtil.isNotNull(mhDic)){
			hql.append(" and news.deleteStatus=?  ");
			values.add(mhDic);
		}
		
		if(DataUtil.isNotNull(typeId)){
			hql.append(" and news.mhNewsType.id=?  ");
			values.add(typeId);
		}
		
		if(DataUtil.isNotNull(mc)){
			hql.append(" and news.status=?  ");
			values.add(mc);
		}
		
		hql.append(" order by news.updateTime desc ");
		List<MhNews> list=this.query(hql.toString(), values.toArray());
		
		
		return list;
	}
	
	@Override
	public void delMhNews(MhNews mhNews){
		this.delete(mhNews);
	}
}
