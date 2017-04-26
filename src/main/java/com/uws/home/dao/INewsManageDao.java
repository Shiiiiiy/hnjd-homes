package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;

/**
 * 门户新闻管理接口
 * @author hejin
 *
 */
public interface INewsManageDao extends IBaseDao{
      
	
	/**
	 * 根据条件查询新闻信息列表
	 * @param search		搜索框参数
	 * @param typeId		新闻类型
	 * @param mhDic         字典表未删除的
	 * @param mhDic01                     字典表（是否已发布）
	 * @return	新闻信息分页结果
	 */
	public Page queryNewsList(String search,String typeId,int pageNo,MhDic mhDic,MhDic mhDic01);
    
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
	 * 查询所有新闻信息
	 * mhDic    字典表未删除的
	 * @return	List<MhNews>    新闻列表
	 */
	public List<MhNews> queryAllNewsList(MhDic mhDic,String typeId,MhDic mc);
	
	/**
	 * 物理删除新闻信息
	 * mhNews   要删除的新闻
	 * @return	void
	 */
	public void delMhNews(MhNews mhNews);
	
}
