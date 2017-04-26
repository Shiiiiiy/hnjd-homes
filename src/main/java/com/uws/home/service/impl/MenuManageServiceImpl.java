package com.uws.home.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.IMenuManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IMenuManageService;
import com.uws.home.service.INewsManageService;

/**
 * @ClassName    MenuManageServiceImpl
 * @Description  门户菜单管理接口实现类
 * @author             联合永道
 * @date         2016-08-25下午16:14:22
 */
@Service("MenuManageServiceImpl")
public class MenuManageServiceImpl extends BaseServiceImpl implements IMenuManageService{
	@Autowired
	private IMenuManageDao iMenuManageDao;
	
	@Override  
	public List<MhMenu> getAllMenuList(MhDic mhDic){
		
		return iMenuManageDao.getAllMenuList(mhDic);
	}
	
	
}
