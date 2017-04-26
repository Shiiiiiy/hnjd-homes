package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhNews;
/**
 * 门户字典管理实现类
 * @author hejin
 *
 */
@Repository("DicManageDaoImpl")
public class DicManageDaoImpl extends BaseDaoImpl implements IDicManageDao{

	@Override
	public List<MhDic> getMhDicListByParentCode(String parentCode){
		MhDic mdic=getMhDicByParentCodeOrId(parentCode,"");
		StringBuffer hql=new StringBuffer("select dic from MhDic dic where 1=1  ");
		List<Object> values=new ArrayList();
		if( mdic!=null & DataUtil.isNotNull(mdic.getId())){
			hql.append(" and dic.mhParentId = ?  ");
			values.add(mdic.getId());
			
		}
		List<MhDic> list=this.query(hql.toString(), values.toArray());
		
		return list;
	}
	
	@Override
    public MhDic getMhDicByParentCodeOrId(String parentCode,String dicId){
		
		StringBuffer hql=new StringBuffer("select dic from MhDic dic where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(parentCode)){
			hql.append(" and dic.mhCode = ?  ");
			values.add(parentCode);
			
		}
		
		if(DataUtil.isNotNull(dicId)){
			hql.append(" and dic.id = ?  ");
			values.add(dicId);
			
		}
		
		 
		
		
		return (MhDic)this.queryUnique(hql.toString(), values.toArray());
		
	 }
	
	
	
}
