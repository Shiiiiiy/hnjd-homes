package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.support.Page;
import com.uws.home.model.MhDic;
import com.uws.home.model.MhMessage;
import com.uws.home.model.MhNews;

/**
 * 门户教学互动评论接口
 * @author hejin
 *
 */
public interface IMessageDao extends IBaseDao{
    
	/**
	 * 根据被评论者id查询当前用户所有的评论（被评论的）
	 * @param mhOwner	   被评论者id
	 * @return	List<MhMessage>  评论信息列表
	 */
	public List<MhMessage> getMhMessageListByMhOwnerId(String mhOwner);
	
	/**
	 * 根据父id查询评论信息列表
	 * @param mhParentId	   被回复的评论id
	 * @return	List<MhMessage> 回复信息列表
	 */
	public List<MhMessage> getMhMessageListByMhParentId(String mhParentId);
	
	
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
	 * 查询一级评论信息列表
	 * @return	List<MhMessage>
	 */
	public List<MhMessage> getMhMessageFirstList();
	
	
	/**
	 * 修改评论状态是否已读
	 * @param mhOwner 被评论人id 
	 * @return	void
	 */
	public void updateMhMessageIsRead(String mhOwner,MhDic mhDic);

	
	/**
	 * 修改评论状态是否已读
	 * @param mhOwner 被评论人id 
	 * @param pageNo  当前页
	 * @return	Page
	 */
	public Page getMhMessagePageListByMhOwnerId(String mhOwner, int pageNo);
 
	/**
	 * 修改评论状态是否已读
	 * @param mhMessageList 评论id列表 
	 * @param mhDic  已读状态
	 * @return	void
	 */
	public void updateMhMessageIsReadByIdList(List<String> mhMessageList, MhDic mhDic);
	
	
	
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
