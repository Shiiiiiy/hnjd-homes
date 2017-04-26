package com.uws.home.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.dao.IConfigManageDao;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.service.IConfigManageService;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.INewsManageService;

/**
 * @ClassName    ConfigManageServiceImpl
 * @Description  门户字典管理接口实现类
 * @author             联合永道
 * @date         2016-08-25下午16:14:22
 */
@Service("ConfigManageServiceImpl")
public class ConfigManageServiceImpl extends BaseServiceImpl implements IConfigManageService{
	@Autowired
	private IConfigManageDao iConfigManageDao;
	
	@Override  
	public MhConfig getMhConfigByUserId(String userId){
		
		return iConfigManageDao.getMhConfigByUserId(userId);
	}
	
	@Override
	public void saveMhConfig(MhConfig mhConfig){
		
		this.iConfigManageDao.saveMhConfig(mhConfig);
	}
	
}
