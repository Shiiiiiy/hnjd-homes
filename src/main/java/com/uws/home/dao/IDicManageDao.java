package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;

/**
 * 门户字典管理接口
 * @author hejin
 *
 */
public interface IDicManageDao extends IBaseDao{
    
	/**
	 * 根据父编码查询字典信息列表
	 * @param parentCode	   父编码
	 * @return	List<MhDic>  父编码对应的字典信息
	 */
	public List<MhDic> getMhDicListByParentCode(String parentCode);
	
	/**
	 * 根据编码或id查询字典信息
	 * @param parentCode	   编码
	 * @param dicId	      id
	 * @return	MhDic  字典信息实体
	 */
	public MhDic getMhDicByParentCodeOrId(String parentCode,String dicId);
}
