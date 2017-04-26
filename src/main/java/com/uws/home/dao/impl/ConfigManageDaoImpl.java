package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IConfigManageDao;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhConfig;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * 用户自定义菜单配置管理实现类
 * @author hejin
 *
 */
@Repository("ConfigManageDaoImpl")
public class ConfigManageDaoImpl extends BaseDaoImpl implements IConfigManageDao{


	  
	@Override
	public MhConfig getMhConfigByUserId(String userId){
		
		StringBuffer hql=new StringBuffer("select dic from MhConfig dic where 1=1  ");
		List<Object> values=new ArrayList();
		if( DataUtil.isNotNull(userId)){
			hql.append(" and dic.mhUserid.id = ?  ");
			values.add(userId);
			
		}
		
		return (MhConfig)this.queryUnique(hql.toString(), values.toArray());
	}
	
	@Override
	public void saveMhConfig(MhConfig mhConfig){
		this.save(mhConfig);
		
	}
	
}
