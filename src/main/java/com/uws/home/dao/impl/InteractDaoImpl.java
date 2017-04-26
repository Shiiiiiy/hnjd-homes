package com.uws.home.dao.impl;


import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IInteractDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhNews;
/**
 * 门户教学互动实现类
 * @author hejin
 *
 */
@Repository("InteractDaoImpl")
public class InteractDaoImpl extends BaseDaoImpl implements IInteractDao{

	
	@Override
	public MhInteract getInteractByUserId(String userId){
		StringBuffer hql=new StringBuffer(" select mi from MhInteract mi where 1=1  ");
		List<Object> values=new ArrayList();
		if(DataUtil.isNotNull(userId)){
			hql.append(" and mi.mhUserid.id = ?  ");
			values.add(userId);
		}
		
		return (MhInteract)this.queryUnique(hql.toString(), values.toArray());
	}
	
	@Override
	public MhInteract getInteractById(String mhInteractId){
		
		return (MhInteract)this.get(MhInteract.class, mhInteractId);
	}
	
	
	@Override
	public void saveInteract(MhInteract mhInteract){
		
		this.save(mhInteract);
	}
	
	
}
