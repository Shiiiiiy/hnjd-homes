package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.IMenuManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMenu;
import com.uws.home.model.MhNews;
/**
 * 门户菜单管理实现类
 * @author hejin
 *
 */
@Repository("MenuManageDaoImpl")
public class MenuManageDaoImpl extends BaseDaoImpl implements IMenuManageDao{

	@Override
	public List<MhMenu> getAllMenuList(MhDic mhDic){
		
		StringBuffer hql=new StringBuffer(" select dic from MhMenu dic where dic.deleteStatus=? order by updateTime desc ");
		
		List<MhMenu> list=this.query(hql.toString(), new Object[]{mhDic});
		
		return list;
	}
	
	@Override
    public MhMenu getOneMenu(MhDic mhDic,String mhMenuId){
		
		StringBuffer hql=new StringBuffer(" select dic from MhMenu dic where dic.deleteStatus=? and dic.id=? ");
		
		
		return (MhMenu)this.queryUnique(hql.toString(), new Object[]{mhDic,mhMenuId});
	}
	
}
