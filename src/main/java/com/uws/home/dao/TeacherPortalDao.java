package com.uws.home.dao;

import java.util.List;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.home.model.MHstatistStudentTuition;
import com.uws.home.model.MhTeacherUser;

public interface TeacherPortalDao extends IBaseDao{
	/**通过 登录的userId 获取门户教师的 一个对象 */
	public MhTeacherUser getMhTeacherUser(String userId);
	/**查询所有可用 的学年列表 降序 */
	public List<String> queryAllShooolYears();
	/**查询所有可用 的学院列表  
	 * @param mhtea */
	public List<String> queryAllAcademy(MhTeacherUser mhtea);
	/**查询 指定的学年 和 学院 查询 此时的 [教职工 总人数，行政类人数，教学类人数] */
	public String[] queryTeacherTypeNum(String schyear, String academyN);
	/**查询  指定的学年 和 学院 查询 此时的  [教职工男性人数，比重， 女性人数，比重]*/
	public String[] queryTeacherSexNum(String schyear, String academyN);
	/**当前学年X  学院   年龄段人数[-30,30-35,35-40,40-45,45-50,50-55,55+ ] 规定集合 (1,4] 开 闭集 模式**/
	public String[] queryTeacherAgeNum(String schyear, String academyN);
	/**查询 工作年限  当前学年X  学院  ["3年以下", "3-5年", "5-10年", "10-20年", "20-50年", "50年以上"*/
	public String[] queryTeacherWorkYearNum(String schyear, String academyN);
	/**查询 当前学年X  学院   List [院系名称,总人数,完全缴,未缴,部分缴,缴费状态]*/
	public List<MHstatistStudentTuition> queryMHstuFeeList(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,List<String> academyList);
	/**查询 当前学年X  学院[待定字段 全] 总人数*/
	public int queryStuNoAll(String schyear, String academyN,List<String> academyList);
	public List<String[]> queryListforbar(String schyear,
			List<String> schyearList, List<String> academyList);
	public String[] queryListforline(String schyear, List<String> schyearList,
			String academyN);
	public MhTeacherUser getMhSuperUser(String userId);
	/***List +[生源地贷人数,校园地贷人数,缓人数,奖人数,助人数,免人数] */
	public List<MHstatistStudentTuition> queryMHstuFeeList2(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,
			List<String> academyList);
	/***男女比 [男  男比  女  女比]比例为 百分制 入学学年*/
	public String[] queryStuSexRate(String schyear, String academyN);
	/** 招生方式  [统招  统招比  自考  自考比]*/
	public String[] queryStuEnrollment(String schyear, String academyN);
	/** 生源地     [河南  其他] */
	public String[] queryStuOriginPlace(String schyear, String academyN);
	/**某学年 不同学院  的在校教职工人数*/
	public List<String[]> queryTeacherNumBar(String schyear,List<String> academyList);
}
