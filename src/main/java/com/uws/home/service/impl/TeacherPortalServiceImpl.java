package com.uws.home.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uws.core.base.BaseServiceImpl;
import com.uws.home.dao.StudentPortalDao;
import com.uws.home.dao.TeacherPortalDao;
import com.uws.home.model.MHstatistStudentTuition;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;
import com.uws.home.model.MhTeacherUser;
import com.uws.home.model.SynchronizedChargeDetialModel;
import com.uws.home.service.StudentPortalService;
import com.uws.home.service.TeacherPortalService;
@Service
public class TeacherPortalServiceImpl extends BaseServiceImpl
	implements TeacherPortalService {
	@Autowired
	public TeacherPortalDao teacherPortalDao;
	@Override
	public MhTeacherUser getMhTeacherUser(String userId) {		
		return this.teacherPortalDao.getMhTeacherUser(userId);
	}
	@Override
	public List<String> queryAllShooolYears() {
		return this.teacherPortalDao.queryAllShooolYears();
	}
	@Override
	public List<String> queryAllAcademy(MhTeacherUser tea) {
		return this.teacherPortalDao.queryAllAcademy(tea);
	}
	@Override
	public String[] queryTeacherTypeNum(String schyear, String academyN) {
		return this.teacherPortalDao.queryTeacherTypeNum(schyear,academyN);
	}
	@Override
	public String[] queryTeacherTypeNumAll(String schyear, String academyN,
			List<String> academyList) {
		String[] ss=new String[]{"0","0","0"};
		for (int i = 0; i < academyList.size(); i++) {
			String[] temp=new String[]{"0","0","0"};
			temp=teacherPortalDao.queryTeacherTypeNum(schyear,academyList.get(i));
			try{
				ss[0]=Integer.valueOf(temp[0])+Integer.valueOf(ss[0])+"";
				ss[1]=Integer.valueOf(temp[1])+Integer.valueOf(ss[1])+"";
				ss[2]=Integer.valueOf(temp[2])+Integer.valueOf(ss[2])+"";
			}catch(Exception e){/*e.printStackTrace();System.out.println("MHCODE-queryTeacherTypeNumAll");*/}
		}
		return ss;
	}
	@Override
	public String getTeaOrgN(List<String> org_Names, List<String> academyList) {
		String orgN="";
		for (int i = 0; i < org_Names.size(); i++) {
			String org_Name=org_Names.get(i);
			for (int j = 0; j < academyList.size(); j++) {
				if(academyList.get(j).equals(org_Name)){
					orgN=org_Name;
					break;
				}				
			}
		}
		return orgN;/*这个只用在Service层实现*/
	}
	@Override
	public String[] queryTeacherSexNum(String schyear, String academyN) {
		return this.teacherPortalDao.queryTeacherSexNum(schyear,academyN);
	}
	@Override
	public String[] queryTeacherAgeNum(String schyear, String academyN) {
		return this.teacherPortalDao.queryTeacherAgeNum(schyear,academyN);
	}
	@Override
	public String[] queryTeacherWorkYearNum(String schyear, String academyN) {
		return this.teacherPortalDao.queryTeacherWorkYearNum(schyear,academyN);
	}
	@Override
	public List<MHstatistStudentTuition> queryMHstuFeeList(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,List<String> academyList) {
		return this.teacherPortalDao.queryMHstuFeeList(schyear,academyN,mHstuFeeList,academyList);
	}
	@Override
	public MHstatistStudentTuition queryMHstuFeeListAll(List<MHstatistStudentTuition> mHstuFeeList) {
		MHstatistStudentTuition mh=new MHstatistStudentTuition();
		/*总人数 ZRS  、完全缴人数 WQJF、  未缴人数WJF 、 部分缴人数  BFJF  、 缴费状态  JFZT*/
		int ZRS=0,WQJF=0,WJF=0,BFJF=0,WQJF1=0,WJF1=0,BFJF1=0,WQJF2=0,WJF2=0,BFJF2=0,WQJF3=0,WJF3=0,BFJF3=0;
		for (int i = 0; i < mHstuFeeList.size(); i++) {
			ZRS  +=mHstuFeeList.get(i).getZRS();
			//三类总计
			WQJF +=mHstuFeeList.get(i).getWQJF();
			WJF  +=mHstuFeeList.get(i).getWJF();
			BFJF +=mHstuFeeList.get(i).getBFJF();
			//学费
			WQJF1 +=mHstuFeeList.get(i).getWQJF1();
			WJF1  +=mHstuFeeList.get(i).getWJF1();
			BFJF1 +=mHstuFeeList.get(i).getBFJF1();	
			//教材费
			WQJF2 +=mHstuFeeList.get(i).getWQJF2();
			WJF2  +=mHstuFeeList.get(i).getWJF2();
			BFJF2 +=mHstuFeeList.get(i).getBFJF2();	
			//住宿费
			WQJF3 +=mHstuFeeList.get(i).getWQJF3();
			WJF3  +=mHstuFeeList.get(i).getWJF3();
			BFJF3 +=mHstuFeeList.get(i).getBFJF3();	
		}
		mh.setZRS((int)ZRS);			
		mh.setWQJF((int)WQJF);		mh.setWJF((int)WJF);			mh.setBFJF((int)BFJF);      
		mh.toaddJFZT();//计算状态
		mh.setWQJF1((int)WQJF1);			mh.setWJF1((int)WJF1);			mh.setBFJF1((int)BFJF1);  
		mh.setWQJF2((int)WQJF2);			mh.setWJF2((int)WJF2);			mh.setBFJF2((int)BFJF2);  
		mh.setWQJF3((int)WQJF3);			mh.setWJF3((int)WJF3);			mh.setBFJF3((int)BFJF3);  
		return mh;
	}
	@Override
	public int queryStuNoAll(String schyear, String academyN,List<String> academyList) {
		return this.teacherPortalDao.queryStuNoAll(schyear,academyN,academyList);
	}
	@Override
	public List<String[]> queryListforbar(String schyear,
			List<String> schyearList, List<String> academyList) {
		return this.teacherPortalDao.queryListforbar(schyear,schyearList,academyList);
	}
	@Override
	public String[] queryListforline(String schyear, List<String> schyearList,
			String academyN) {
		return this.teacherPortalDao.queryListforline(schyear,schyearList,academyN);
	}
	@Override
	public MhTeacherUser getMhSuperUser(String userId) {
		return this.teacherPortalDao.getMhSuperUser(userId);
	}
	@Override
	public List<MHstatistStudentTuition> queryMHstuFeeList2(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,
			List<String> academyList) {
		return this.teacherPortalDao.queryMHstuFeeList2(schyear,academyN,mHstuFeeList,academyList);
	}
	@Override
	public String[] queryStuSexRate(String schyear, String academyN) {
		return this.teacherPortalDao.queryStuSexRate(schyear,academyN);
	}
	@Override
	public String[] queryStuEnrollment(String schyear, String academyN) {
		return this.teacherPortalDao.queryStuEnrollment(schyear,academyN);
	}
	@Override
	public String[] queryStuOriginPlace(String schyear, String academyN) {
		return this.teacherPortalDao.queryStuOriginPlace(schyear,academyN);
	}
	@Override
	public List<String[]> queryTeacherNumBar(String schyear,
			List<String> academyList) {
		return this.teacherPortalDao.queryTeacherNumBar(schyear,academyList);
	}

	
}
