package com.uws.home.dao;

import java.util.List;

import com.uws.core.base.IBaseService;
import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;

public interface StudentPortalDao extends IBaseDao {
	/**依据 学号 获取 一个登录学生  门户网  用对象*/
	public MhStuUser getMhStuUser(String xH);
	/**依据 学号 院系  一个学生  此学年已缴 费用总和 包括  学费 课本费 住宿费*/
	public String getMhStuCurrentFee(String xH, String yuanxi);
	/**
	 * 依据 一个学生学号    获取 此学生 从指定学年的 总费用,学费,课本费,住宿费 的
	 * 应交 实缴  欠费 减免 情况*/
	public MhStuUserTuition getMhStuTuition(String XH, String year);
	/**通过 userId 判断 用户 是学生还是教师 并返回字符串结果 ""其他  "学生" "教师"*/
	public String isTeaOrStu(String userId);
	/**返回所有与该生相关的可评价的老师 */
	public List<String[]> getMhStuRelatedTea(MhStuUser stuUser);
	/**查询学号为 xh的学生本月未签到次数 */
	public String getMhStuNotSign(String xh);
}
