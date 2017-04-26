package com.uws.home.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.home.dao.StudentPortalDao;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;
import com.uws.home.model.SynchronizedChargeDetialModel;
import com.uws.home.service.StudentPortalService;
@Service
public class StudentPortalServiceImpl extends BaseServiceImpl
	implements StudentPortalService {
	@Autowired
	public StudentPortalDao studentPortalDao;
	//
	public MhStuUser getMhStuUser(String XH){
		return this.studentPortalDao.getMhStuUser(XH);
	}
	
	@Override
	public String getMhStuCurrentFee(String XH, String yuanxi) {
		return this.studentPortalDao.getMhStuCurrentFee(XH,yuanxi);
	}

	@Override
	public List<MhStuUserTuition> getMhStuTuitionDetails(MhStuUser stuUser) {
		//获取最新学年  和  入学学年
		Calendar cal = Calendar.getInstance();
		int nowYear = cal.get(Calendar.YEAR);
		int nowMon = cal.get(Calendar.MONTH)+1;
		nowYear=(nowMon<=8)?nowYear-1:nowYear;
		String ruxueYear=stuUser.getRXND();//入学学年
		String lixiaoYear=stuUser.getLXND();//离校
		String SFZH=stuUser.getSFZH();
		List<MhStuUserTuition> list=new ArrayList<MhStuUserTuition>();	
		try{
		if(lixiaoYear!=null && !("".equals(lixiaoYear)) &&ruxueYear!=null&&!("".equals(ruxueYear))){
			int  ruxueYear1 = Integer.parseInt(ruxueYear);
			int  lixiaoYear1 = Integer.parseInt(lixiaoYear);
			nowYear=nowYear>lixiaoYear1?lixiaoYear1:nowYear;
			nowYear=nowYear<ruxueYear1?ruxueYear1:nowYear;
			if(nowYear>=ruxueYear1){
				//进行遍历  调用  dao层方法  依次为MhStuUserTuition 赋值
				for(int i=nowYear;i>=ruxueYear1;i--){
					list.add(  this.studentPortalDao.getMhStuTuition(SFZH,i+"")  );
				}
			}
		}
		}catch (Exception e) {/*e.printStackTrace();System.out.println("MHCODE-getMhStuTuitionDetails-SerImpl");*/}		
		return list;
	}

	@Override
	public String isTeaOrStu(String userId) {
		return this.studentPortalDao.isTeaOrStu(userId);
	}

	@Override
	public List<String[]> getMhStuRelatedTea(MhStuUser stuUser) {
		return this.studentPortalDao.getMhStuRelatedTea(stuUser);
	}
	/**查询身份证为 的学生本月未签到次数 */
	@Override
	public String getMhStuNotSign(String sfz) {
		return this.studentPortalDao.getMhStuNotSign(sfz);
	}
}
