package com.uws.home.service;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhNews;
/**
 * @ClassName    IInteractService
 * @Description  教学互动service
 * @author       何进
 * @date         2016-08-29上午11:34:22
 */
public interface IInteractService extends IBaseService{
      

	/**
	 * 根据用户id查询教学互动信息
	 * @param userId	   用户id
	 * @return	MhInteract  教学互动信息
	 */
	public MhInteract getInteractByUserId(String userId);
	
	/**
	 * 根据id查询教学互动信息
	 * @param mhInteractId	   教学互动信息id
	 * @return	MhInteract  教学互动信息
	 */
	public MhInteract getInteractById(String mhInteractId);
	
	
	/**
	 * 新增或修改教学互动信息
	 * @param mhInteract	   教学互动信息实体
	 * @return	void
	 */
	public void saveInteract(MhInteract mhInteract);
	
}
