package com.uws.home.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.INewsManageService;

/**
 * @ClassName    DicManageServiceImpl
 * @Description  门户字典管理接口实现类
 * @author             联合永道
 * @date         2016-08-25下午16:14:22
 */
@Service("DicManageServiceImpl")
public class DicManageServiceImpl extends BaseServiceImpl implements IDicManageService{
	@Autowired
	private IDicManageDao iDicManageDao;
	
	@Override  
	public List<MhDic> getMhDicListByParentCode(String parentCode){
		
		return iDicManageDao.getMhDicListByParentCode(parentCode);
	}
	
	@Override
	public MhDic getMhDicByParentCodeOrId(String parentCode,String dicId){
		
		return this.iDicManageDao.getMhDicByParentCodeOrId(parentCode, dicId);
	}
	
}
