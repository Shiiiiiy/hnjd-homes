package com.uws.home.service.impl;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.core.util.DataUtil;
import com.uws.core.util.IdUtil;
import com.uws.home.dao.IDicManageDao;
import com.uws.home.dao.IMessageDao;
import com.uws.home.dao.INewsManageDao;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;
import com.uws.home.service.IDicManageService;
import com.uws.home.service.IMessageService;
import com.uws.home.service.INewsManageService;
import java.util.*;
/**
 * @ClassName    MessageServiceImpl
 * @Description  门户教学互动评论接口实现类
 * @author             联合永道
 * @date         2016-08-30下午15:34:22
 */
@Service("MessageServiceImpl")
public class MessageServiceImpl extends BaseServiceImpl implements IMessageService{
	@Autowired
	private IMessageDao iMessageDao;
	
	@Autowired
	private IDicManageDao iDicManageDao;
	
	@Override
	public List<MhMessage> getUserAllMessagesByMhOwnerId(String mhOwner){
		List<MhMessage> list=iMessageDao.getMhMessageListByMhOwnerId(mhOwner);
		for(MhMessage mhm:list){
			List<MhMessage> list01=iMessageDao.getMhMessageListByMhParentId(mhm.getId());
			if(list01.size()>0){
				mhm.setReceive(list01);
			}
		}
		
		return list;
	}
	
	@Override
	public Map<String,Object> getMessagesPageByMhOwnerId(String mhOwner,int pageNo){
		Page page=iMessageDao.getMhMessagePageListByMhOwnerId(mhOwner, pageNo);
		List<MhMessage> list=(List<MhMessage>)page.getResult();
		for(MhMessage mhm:list){
			List<MhMessage> list01=iMessageDao.getMhMessageListByMhParentId(mhm.getId());
			if(list01.size()>0){
				mhm.setReceive(list01);
			}
		}
		
		Map<String,Object> map=new HashMap();
		map.put("allMessageList", list);
		map.put("allCount", page.getTotalCount());
		return map;
	}
	
	
	@Override
	public List<MhMessage> getUserAllMessagesByMhSenderId(String mhSender,String teacherId){
		
		List<MhMessage> list=iMessageDao.getMhMessageListByMhOwnerId(teacherId);
		//System.out.println("==评论内容list.size================"+list.size());
		Iterator<MhMessage> it=list.iterator();
		MhMessage mss=null;
		while(it.hasNext()){
			mss=it.next();
			/*
			System.out.println("==========......======");
			System.out.println("mss.getMhSender()================"+mss.getMhSender().getId());
			System.out.println("==mss.getMhOwner()================"+mss.getMhOwner().getId());
			System.out.println("==mhSender================"+mhSender);
			System.out.println("============......====");*/
			
			if(mss.getMhSender().getId().equals(mhSender)){
				//System.out.println("==评论内容01================"+mss.getMhContent());
				mss.setReceive(iMessageDao.getMhMessageListByMhParentId(mss.getId()));
			}else{
				
				List<MhMessage> list01=iMessageDao.getMhMessageListByMhParentId(mss.getId());
				List<MhMessage> list02=new ArrayList();
				int x=0;
				if(list01!=null && list01.size()>0){
				
					for(MhMessage mh:list01){
						if(mh.getMhSender().getId().equals(mhSender)){
							
							list02.add(mh);
							 x++;
						}
					}
				}
				if(x==0){
					it.remove();
				}else if(x>0){
					//System.out.println("==评论内容03================"+mss.getMhContent());
					mss.setReceive(list02);
				}
				x=0;
			}
		}		
		
		
		return list;
	}
	
	
	@Override
	public MhMessage getMhMessageListById(String mhMessageId){
		
		return this.iMessageDao.getMhMessageListById(mhMessageId);
	}
	
	
	@Override
	public void saveMhMessage(MhMessage mhMessage){
		
		this.iMessageDao.saveMhMessage(mhMessage);
	}
	
	@Override
	public void updateMhMessageIsRead(String mhOwner){
		
		iMessageDao.updateMhMessageIsRead(mhOwner, iDicManageDao.getMhDicByParentCodeOrId("READ", ""));
	}
	
	@Override
	public void updateMhMessageIsReadByIdList(List<MhMessage> mhMessageList){
		List<String> list=new ArrayList();
		if(mhMessageList!=null && mhMessageList.size()>0){
			for(MhMessage mm:mhMessageList){
				list.add(mm.getId());
			}
			iMessageDao.updateMhMessageIsReadByIdList(list, iDicManageDao.getMhDicByParentCodeOrId("READ", ""));
		}
		
		
	}
	
	
	@Override  
	public void deleteMhMessageById(String mhMessageId){
		
		this.iMessageDao.deleteMhMessageById(mhMessageId);
		
	}
	
	@Override 
	public void deleteMhMessageByMhParentId(String mhParentId){
		this.iMessageDao.deleteMhMessageById(mhParentId);
		this.iMessageDao.deleteMhMessageByMhParentId(mhParentId);
	}
	
}
