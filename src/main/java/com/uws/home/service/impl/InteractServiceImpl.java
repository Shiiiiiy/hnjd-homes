package com.uws.home.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.IInteractDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhNews;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IInteractService;
import com.uws.home.service.INewsManageService;

/**
 * @ClassName    InteractServiceImpl
 * @Description  门户教学互动接口实现类
 * @author             联合永道
 * @date         2016-08-29下午13:14:22
 */
@Service("InteractServiceImpl")
public class InteractServiceImpl extends BaseServiceImpl implements IInteractService{
	@Autowired
	private IInteractDao iInteractDao;
	
	
	public MhInteract getInteractByUserId(String userId){
		
		return iInteractDao.getInteractByUserId(userId);
	}
	
	
	public MhInteract getInteractById(String mhInteractId){
		
		return iInteractDao.getInteractById(mhInteractId);
	}
	
	
	
	public void saveInteract(MhInteract mhInteract){
		
		iInteractDao.saveInteract(mhInteract);
	}
	
}
