package com.uws.home.service;

import java.util.List;
import java.util.Map;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;
/**
 * @ClassName    IMessageService
 * @Description  门户教学互动评论service
 * @author       何进
 * @date         2016-08-29下午17:30:22
 */
public interface IMessageService extends IBaseService{
      
	/**
	 * 根据被评论者id查询当前用户所有的评论（被评论的）
	 * @param mhOwner	   被评论者id
	 * @return	List<MhMessage>  评论信息列表
	 */
	public List<MhMessage> getUserAllMessagesByMhOwnerId(String mhOwner);
	
	/**
	 * 根据评论人id查询评论信息列表
	 * @param mhSender	   评论人id
	 * @param teacherId  被评论的老师id
	 * @return	List<MhMessage> 回复信息列表
	 */
	public List<MhMessage> getUserAllMessagesByMhSenderId(String mhSender,String teacherId);
	
	
	/**
	 * 根据id查询评论信息
	 * @param mhMessageId  评论id
	 * @return	MhMessage 评论信息
	 */
	public MhMessage getMhMessageListById(String mhMessageId);
	
	
	
	/**
	 * 保存评论信息
	 * @param mhMessage 评论信息
	 * @return	void
	 */
	public void saveMhMessage(MhMessage mhMessage);
	
	
	/**
	 * 修改评论状态是否已读
	 * @param mhOwner 被评论人id 
	 * @return	void
	 */
	public void updateMhMessageIsRead(String mhOwner);

	/**
	 * 修改评论状态是否已读
	 * @param mhOwner 被评论人id 
	 * @param pageNo  当前页
	 * @return	List<MhMessage>
	 */
	public Map<String,Object> getMessagesPageByMhOwnerId(String mhOwner, int pageNo);
	
	
	/**
	 * 修改评论状态是否已读
	 * @param mhMessageList 评论列表 
	 * @return	void
	 */
	public void updateMhMessageIsReadByIdList(List<MhMessage> mhMessageList);
	
	
	/**
	 * 根据评论id删除一条评论
	 * @param mhMessageId  评论id
	 * @return	void
	 */
	public void deleteMhMessageById(String mhMessageId);
	
	/**
	 * 根据父评论id批量删除评论
	 * @param mhParentId  父评论id
	 * @return	void
	 */
	public void deleteMhMessageByMhParentId(String mhParentId);
	
	
}
