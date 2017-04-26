package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * @ClassName    IDicManageService
 * @Description  门户字典管理service
 * @author       何进
 * @date         2016-08-25下午16:14:22
 */
public interface IDicManageService extends IBaseService{
      

	/**
	 * 根据父编码查询字典信息列表
	 * @param parentCode	   父编码
	 * @return	List<MhDic>  父编码对应的字典信息
	 */
	public List<MhDic> getMhDicListByParentCode(String parentCode);
	
	/**
	 * 根据父编码或id查询字典信息
	 * @param parentCode	   父编码
	 * @param dicId	      id
	 * @return	MhDic  字典信息实体
	 */
	 public MhDic getMhDicByParentCodeOrId(String parentCode,String dicId);
}
