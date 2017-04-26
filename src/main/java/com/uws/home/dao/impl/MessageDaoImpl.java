package com.uws.home.dao.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import java.util.*;


import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.IInteractDao;
import com.uws.home.dao.IMessageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhInteract;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;
/**
 * 门户教学互动评论实现类
 * @author hejin
 *
 */
@Repository("MessageDaoImpl")
public class MessageDaoImpl extends BaseDaoImpl implements IMessageDao{

	@Autowired
	private IDicManageDao iDicManageDao;
	
	@Override 
	public List<MhMessage> getMhMessageListByMhOwnerId(String mhOwner){
		StringBuffer hql=new StringBuffer(" select mm from MhMessage mm where 1=1 and mm.deleteStatus=? ");
		List<Object> values=new ArrayList();
		values.add(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""));
		if(DataUtil.isNotNull(mhOwner)){
			hql.append(" and mm.mhOwner.id = ?  ");
			values.add(mhOwner);
		}
		
		hql.append(" and mm.mhParentId is null  order by createTime desc ");
		
		return (List<MhMessage>)this.query(hql.toString(), values.toArray());
	}
	
	
	@Override 
	public Page getMhMessagePageListByMhOwnerId(String mhOwner,int pageNo){
		StringBuffer hql=new StringBuffer(" select mm from MhMessage mm where 1=1 and mm.deleteStatus=? ");
		List<Object> values=new ArrayList();
		values.add(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""));
		if(DataUtil.isNotNull(mhOwner)){
			hql.append(" and mm.mhOwner.id = ?  ");
			values.add(mhOwner);
		}
		hql.append(" and mm.mhParentId is null  order by createTime desc ");
		
		if (values.size() == 0){
			return this.pagedQuery(hql.toString(), pageNo, 10);
		}else{
			return this.pagedQuery(hql.toString(),pageNo, 10,values.toArray() );
		}
	}
	
	
	@Override 
	public List<MhMessage> getMhMessageListByMhParentId(String mhParentId){
		StringBuffer hql=new StringBuffer(" select mm from MhMessage mm where 1=1 and mm.deleteStatus=? ");
		List<Object> values=new ArrayList();
		values.add(iDicManageDao.getMhDicByParentCodeOrId("NORMAL", ""));
		if(DataUtil.isNotNull(mhParentId)){
			hql.append(" and mm.mhParentId= ?  ");
			values.add(mhParentId);
		}
		hql.append("  order by createTime desc ");
		return (List<MhMessage>)this.query(hql.toString(), values.toArray());
	}
	
	
	@Override 
	public List<MhMessage> getMhMessageFirstList(){
		StringBuffer hql=new StringBuffer(" select mm from MhMessage mm where 1=1 and mm.mhParentId is null and mm.deleteStatus=? ");
		hql.append("  order by createTime desc ");
		List<MhMessage> list=this.query(hql.toString(),new Object[]{iDicManageDao.getMhDicByParentCodeOrId("NORMAL", "")});
		
		return list;
	}
	
	
	@Override 
	public MhMessage getMhMessageListById(String mhMessageId){
		
		return (MhMessage)this.get(MhMessage.class, mhMessageId);
	}
	
	
	@Override 
	public void saveMhMessage(MhMessage mhMessage){
		
		this.save(mhMessage);
	}
	
	@Override 
	public void updateMhMessageIsRead(String mhOwner,MhDic mhDic){
		StringBuffer hql=new StringBuffer("update MhMessage mss  set mss.mhIsread=? where mss.mhOwner.id=? ");
		List<Object> values=new ArrayList();
		values.add(mhDic);
		values.add(mhOwner);
		this.executeHql(hql.toString(), values.toArray());
	}
	
	
	@Override 
	public void updateMhMessageIsReadByIdList(List<String> mhMessageList,MhDic mhDic){
		StringBuffer hql=new StringBuffer("update MhMessage mss  set mss.mhIsread=:mhIsread where mss.id in(:idList) ");
		Map<String,Object> valuess = new HashMap();
		valuess.put("mhIsread", mhDic);
		valuess.put("idList", mhMessageList);
		
		this.executeHql(hql.toString(), valuess);
	}
	
	@Override  
	public void deleteMhMessageById(String mhMessageId){
		MhMessage mse=(MhMessage)this.get(MhMessage.class, mhMessageId);
		mse.setDeleteStatus(iDicManageDao.getMhDicByParentCodeOrId("DELETED", ""));
		this.save(mse);
		
	}
	
	@Override 
	public void deleteMhMessageByMhParentId(String mhParentId){
		StringBuffer hql=new StringBuffer("update MhMessage mss  set mss.deleteStatus=? where mss.mhParentId=? ");
		List<Object> values=new ArrayList();
		values.add(iDicManageDao.getMhDicByParentCodeOrId("DELETED", ""));
		values.add(mhParentId);
		this.executeHql(hql.toString(), values.toArray());
	}
	
	
}
