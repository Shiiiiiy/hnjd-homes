package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * @ClassName    INewsManageService
 * @Description  门户新闻管理service
 * @author       何进
 * @date         2016-08-25下午16:14:22
 */
public interface INewsManageService extends IBaseService{
      
	/**
	 * 根据条件查询新闻信息列表
	 * @param search		搜索框参数
	 * @param typeId		新闻类型
	 * @return	新闻信息分页结果
	 */
	public Page queryNewsList(String search,String typeId,int pageNo);
	
	/**
	 * 新增一条新闻信息
	 * @param mhNews		新闻实体
	 * @return	void
	 */
	public void addNews(MhNews mhNews);
	
	/**
	 * 根据id查询一条新闻信息
	 * @param mhNewsId		新闻实体id
	 * @return	MhNews      新闻实体
	 */
	public MhNews queryNewsById(String mhNewsId);

	
	/**
	 * 根据id查询一条新闻的上一条和下一条
	 * @param mhNewsId		新闻实体id
	 * @return	List<MhNews>      新闻实体列表
	 */
	public List<MhNews> queryTwoMhNews(String mhNewsId,MhNews ms,String typeId);
	
	/**
	 * 物理删除新闻信息
	 * mhNews   要删除的新闻
	 * @return	void
	 */
	public void delMhNews(MhNews mhNews);
}
