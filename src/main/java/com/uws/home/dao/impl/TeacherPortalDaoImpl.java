package com.uws.home.dao.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.uws.core.hibernate.dao.IBaseDao;
import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.home.dao.StudentPortalDao;
import com.uws.home.dao.TeacherPortalDao;
import com.uws.home.model.MHstatistStudentTuition;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhTeacherUser;
import com.uws.home.service.impl.RoleManageServiceImpl;

import freemarker.core._RegexBuiltins.replace_reBI;
@Repository
public class TeacherPortalDaoImpl extends BaseDaoImpl implements TeacherPortalDao{
	@Resource(name = "mhJdbcTemplate")
	private JdbcTemplate mhJdbcTemplate;//自己门户
	@Resource(name = "mhJdbcTemplate")
	private JdbcTemplate bdpJdbcTemplate;//教师表  在门户
	@Resource(name = "mhJdbcTemplate")
	private JdbcTemplate schoolRollJdbcTemplate ;//学工库  在门户
	@Resource(name="financeJdbcTemplate")
	private JdbcTemplate financeJdbcTemplate;//财务库  去财务
	@Resource(name="RoleManageServiceImpl")
	private RoleManageServiceImpl roleManageServiceImpl;//本地  对接权限
	/**通过 登录的userId 获取门户教师的 一个对象 */
	//教师门户的统计使用的是SFZF的DISTINCT  都是 这样的宏观语句
	public MhTeacherUser getMhTeacherUser(String userId){
		//ID 姓名[ec_teacher] 机构ID[user_org_position]  机构名称[org]  学年[输入]  权限[之后判断]
		MhTeacherUser mhs=new MhTeacherUser();
		Calendar cal = Calendar.getInstance();	
		int nowYear = cal.get(Calendar.YEAR); 
		int nowMon = cal.get(Calendar.MONTH)+1;
		nowYear=(nowMon<=8)?nowYear-1:nowYear;
		mhs.setNowYear(nowYear+"");      //封装当前学年信息
		mhs.setIsFullPower("false");     //封装非 管理员身份
		mhs.setUSER_ID(userId);// 封装  userId
		String TEACHER_NAME="";
		try{
			String sql="select A.NAME from B_USER A where A.ID = ?";
			TEACHER_NAME=this.mhJdbcTemplate.queryForObject(sql,new Object[]{userId},String.class);
		}catch(Exception e){/*e.printStackTrace();*//*System.out.println("MHCODE-getMhTeacherUser-001");*/}
		mhs.setTEACHER_NAME(TEACHER_NAME);// 封装  姓名
		List<String> ORG_IDS = new  ArrayList<String>();//默认菜单权限 很有必要
		List<String> ORG_NAMES = new  ArrayList<String>();
		try{
			String ORG_TYPE=this.getDicID("INSTITUTE", "ORG_TYPE");//只要类型是学院的
			String STATUS= this.getDicID("ENABLE", "STATUS_ENABLE_DISABLE"); 
			String sql="select A.ORG_ID from USER_ORG_POSITION A where A.USER_ID = ? and A.ORG_ID in (select B.ID from ORG B where B.ORG_TYPE = ? and B.STATUS =? )";
			List<Map<String, Object>>  list=this.mhJdbcTemplate.queryForList(sql,userId,ORG_TYPE,STATUS);
			//System.out.println(userId+" "+ORG_TYPE+" "+STATUS);
			Iterator<Map<String, Object>> iterator = list.iterator();
			while (iterator.hasNext()) {
				Map map4book = (Map) iterator.next();
				ORG_IDS.add( (String)map4book.get("ORG_ID") );
				//System.out.println(map4book.get("ORG_ID"));
			}//取多行
			for(int k=0;k<ORG_IDS.size();k++){
				String sql1="select A.NAME from ORG A where A.ID = ? ";
				String  NAME=this.mhJdbcTemplate.queryForObject(sql1,new Object[]{ORG_IDS.get(k)},String.class);
				//System.out.println("TEA封装默认:"+NAME+" "+ORG_IDS.get(k));//目前是有效的10-13
				ORG_NAMES.add(NAME); 
			}
		}catch(Exception e){}
		mhs.setORG_ID(ORG_IDS);     //机构id  多
		mhs.setORG_NAME(ORG_NAMES);  //机构名称   多
		return mhs;	
	}

	@Override
	public List<String> queryAllShooolYears() {
		List<String> shooolYears=new ArrayList<String>();
		try{
			String sql="select A.ID from DIC_CATEGORY A where A.CODE = ? and A.STATUS = ? ";
			String ShooolYearId=(String)this.mhJdbcTemplate.queryForObject(sql,new Object[]{"SCHOOL_YEAR","1"},String.class);//查询学年在字典DIC_CATEGORY的ID
			sql="select A.CODE from DIC A where A.DIC_CATEGORY_ID = ? and A.STATUS = ? order by A.NAME ";//在字典表中获取所有的学年值
			List<Map<String, Object>>  list=this.mhJdbcTemplate.queryForList(sql,ShooolYearId,"1");
			Iterator<Map<String, Object>> iterator = list.iterator();
			while (iterator.hasNext()) {
				Map map4book = (Map) iterator.next();
				shooolYears.add(  (String)map4book.get("CODE")  );//■name是2014-2015    code是2014■
			}//取所有行
		}catch(Exception e){}
		//进行 倒序排列  
			int size = shooolYears.size();
			if( size <= 1){return shooolYears;}
			String[] arr = (String[])shooolYears.toArray(new String[size]); 
			Arrays.sort(arr);
			List<String> shooolYearsSort = Arrays.asList(arr);  
		Collections.reverse(shooolYearsSort);//倒序排列
		return shooolYearsSort;
	}
	@Override
	public List<String> queryAllAcademy(MhTeacherUser TeaUser) {
		List<String> academyList=new ArrayList<String>();
		try{//这里加权限
			String userId=TeaUser.getUSER_ID();
			Map<String, String> map=roleManageServiceImpl.getUserDataPermisson(userId);
			if(map==null){return academyList;}
			String sql="select A.NAME from ORG A where A.ID = ? ";
			if(map.containsKey("defualt_college")){
				String zhi=map.get("defualt_college");
				if("defualt_college".equals(zhi)){//取默认的
					List<String> list=TeaUser.getORG_ID();
					for (int i = 0; i < list.size(); i++) {
						try{
						String AcademyName=this.mhJdbcTemplate.queryForObject(sql,new Object[]{list.get(i)},String.class);
						academyList.add(AcademyName);
						}catch(Exception e){}
					}		
				}
			}else if(map.containsKey("collegeList")){//取自定义权限的
				String AcademyList=map.get("collegeList");
				if(!("".equals(AcademyList)) ){
					String[] zidingyi =AcademyList.split(",");
					for (int i = 0; i < zidingyi.length; i++) {
						try{
							String AcademyName=this.mhJdbcTemplate.queryForObject(sql,new Object[]{zidingyi[i]},String.class);
							academyList.add(AcademyName);
						}catch(Exception e){}
					}
				}
			}
		}catch(Exception e){}
		return academyList;
	}
	@Override
	/**参数：学年   学院名称*/
	public String[] queryTeacherTypeNum(String schyear, String academyN) {//作废功能
		String[] ss=new String[]{"0","0","0"};
		/*EC_TEACHER  CAMPUS的字段 是否有值决定了统计是否有结果 */
		try{		
			String DIC_CATEGORY_ID_00=(String)this.mhJdbcTemplate.queryForObject("select A.ID from DIC_CATEGORY A where A.CODE = ?", new Object[]{"POSITIONKIND_CODE"},String.class);
			String sql00="select A.ID from DIC A where A.CODE = ? and A.STATUS = ? and A.DIC_CATEGORY_ID = ?";
			String JXID = (String)this.bdpJdbcTemplate.queryForObject(sql00, new Object[]{"TEACHING","1",DIC_CATEGORY_ID_00},String.class);//教学
			String XZID = (String)this.bdpJdbcTemplate.queryForObject(sql00, new Object[]{"ADMINISTRATIVE","1",DIC_CATEGORY_ID_00},String.class);//行政
			//
			String DIC_CATEGORY_ID=this.mhJdbcTemplate.queryForObject("select A.ID from DIC_CATEGORY A where A.CODE = ?",new Object[]{"STATUS_ENABLE_DISABLE"},String.class);
			String STATUS=this.mhJdbcTemplate.queryForObject("select A.ID from DIC A where A.CODE = ? and A.DIC_CATEGORY_ID = ? ",new Object[]{"ENABLE",DIC_CATEGORY_ID},String.class);
			String sql="select A.ID from ORG A where A.NAME = ? and A.STATUS = ?";//在 org 状态等于启用
			String academyID = (String)this.bdpJdbcTemplate.queryForObject(sql, new Object[]{academyN,STATUS},String.class);
			String sql1="select count(*) from EC_TEACHER A where A.CAMPUS = ? and A.JOINJOB_YEARS < to_date(?,'yyyy')  ";
			String numberAll = (String)this.bdpJdbcTemplate.queryForObject(sql1, new Object[]{academyID,schyear}, String.class);
			String sql2="select count(*) from EC_TEACHER A where A.CAMPUS = ? and A.JOINJOB_YEARS < to_date(?,'yyyy') " +
					"and A.POSITIONKIND_CODE = ? ";
			String numberXZ = (String)this.bdpJdbcTemplate.queryForObject(sql2, new Object[]{academyID,schyear,XZID}, String.class);
			String numberJW = (String)this.bdpJdbcTemplate.queryForObject(sql2, new Object[]{academyID,schyear,JXID}, String.class);
			ss[0]=numberAll;ss[1]=numberXZ;ss[2]=numberJW;
			//System.out.println(schyear+" "+academyN);
		}catch(Exception e){/*e.printStackTrace();*//*System.out.println("MHCODE-queryTeacherTypeNum");*/}
		return ss;
	}
	@Override
	public String[] queryTeacherSexNum(String schyear, String academyN) {
		String[] ss=new String[]{"0","0","0","0"};
		//[教职工男性人数，比重， 女性人数，比重]	
		try {
				String sql00="select A.ID from DIC A where A.CODE = ?";
			String ManID = (String)this.bdpJdbcTemplate.queryForObject(sql00, new Object[]{"MALE"},String.class);
			String WomanID  = (String)this.bdpJdbcTemplate.queryForObject(sql00, new Object[]{"FEMALE"},String.class);
			String academyID = (String)this.bdpJdbcTemplate.queryForObject("select A.ID from ORG A where A.NAME = ?",new Object[]{academyN},String.class);
				String sql0="select A.ID from DIC_CATEGORY A where A.CODE = ? and A.STATUS = ? ";
			String USER_TYPEID=this.mhJdbcTemplate.queryForObject(sql0, new Object[]{"USER_TYPE","1"},String.class);
				String sql="select A.ID from DIC A where A.CODE = ? and A.DIC_CATEGORY_ID = ? and A.STATUS = ? ";
			String TeaTypeId=this.mhJdbcTemplate.queryForObject(sql, new Object[]{"TEACHER",USER_TYPEID,"1"},String.class);
			String STATUS=this.getDicID("ENABLE", "USER_STATUS");
			String DELETE_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql01="select count(*) from B_USER A where A.USER_TYPE = ? and A.GENDER = ? "+
				" and A.ID in (select B.USER_ID from USER_LOGIN B where substr( B.LOGIN_NAME,0,4) <= ? )"+  
				" and A.ID in (select C.USER_ID from USER_ORG_POSITION C where C.ORG_ID = ? ) "+
				" and A.STATUS = ? "+
				" and A.DELETE_STATUS = ? ";
					;//B_USER 类型是老师+ 性别是男+ schyear前入职+academyN院的老师
					//教师的登录名 19870005 截取入职时间 substr(USER_LOGIN, 0, 4);oracle专用substr函数
			long ManN = (Long)this.bdpJdbcTemplate.queryForLong(sql01, new Object[]{TeaTypeId,ManID,schyear,academyID,STATUS,DELETE_STATUS});
			long WomanN = (Long)this.bdpJdbcTemplate.queryForLong(sql01, new Object[]{TeaTypeId,WomanID,schyear,academyID,STATUS,DELETE_STATUS});
			//System.out.println(academyN+" "+schyear+" "+ManID+" "+WomanID+" "+ManN+" "+WomanN);
			double All=ManN+WomanN;
			double ManRate=0,WoManRate=0;
			if(All!=0.0){ ManRate   =ManN /All; 	WoManRate =WomanN /All;}
			//System.out.println(ManRate+" "+WoManRate+ " "+All);
			DecimalFormat df=new DecimalFormat("#0.#");  
			ss[0]=ManN+""; ss[2]=WomanN+"";
			ss[1]=df.format(ManRate*100).toString();
			ss[3]=df.format(WoManRate*100).toString();
		} catch (DataAccessException e) {} 
		return ss;
	}
	@Override
	public String[] queryTeacherAgeNum(String schyear, String academyN) {
		//年龄 当前学年X 学院 年龄段人数 [-30,30-35,35-40,40-45,45-50,50-55,55+ ]
		String[] ta=new String[]{"0","0","0", "0","0","0","0"};
		try{
			String academyID = (String)this.bdpJdbcTemplate.queryForObject("select A.ID from ORG A where A.NAME = ?",new Object[]{academyN},String.class);
			String USER_TYPEID=this.mhJdbcTemplate.queryForObject("select A.ID from DIC_CATEGORY A where A.CODE = ? and A.STATUS = ? ", new Object[]{"USER_TYPE","1"},String.class);
			String TeaTypeId=this.mhJdbcTemplate.queryForObject("select A.ID from DIC A where A.CODE = ? and A.DIC_CATEGORY_ID = ? and A.STATUS = ? ", new Object[]{"TEACHER",USER_TYPEID,"1"},String.class);
			String STATUS=this.getDicID("ENABLE", "USER_STATUS");
			String DELETE_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql="select count(*) from B_USER A where A.USER_TYPE = ? "+ 
				" and A.ID in (select B.USER_ID from USER_LOGIN B where substr(B.LOGIN_NAME,0,4) <= ? )"+
				" and (to_char(sysdate,'yyyy')-substr(A.CERT_NUM,7,4)) BETWEEN ? AND ? "+ 
				" and A.ID in (select C.USER_ID from USER_ORG_POSITION C where C.ORG_ID = ? ) "+
				" and A.STATUS = ? "+
				" and A.DELETE_STATUS = ? ";//B_USER生日是用字符串存储的
			//注意 部分老师没有身份证
			long s1=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,-200,29,academyID,STATUS,DELETE_STATUS});
			long s2=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,30,34,academyID,STATUS,DELETE_STATUS});
			long s3=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,35,39,academyID,STATUS,DELETE_STATUS});
			long s4=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,40,44,academyID,STATUS,DELETE_STATUS});
			long s5=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,45,49,academyID,STATUS,DELETE_STATUS});
			long s6=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,50,54,academyID,STATUS,DELETE_STATUS});
			long s7=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,55,200,academyID,STATUS,DELETE_STATUS});
			ta[0]=s1+"";ta[1]=s2+"";ta[2]=s3+"";ta[3]=s4+"";ta[4]=s5+"";ta[5]=s6+"";ta[6]=s7+"";
		}catch (Exception e) {System.out.println("MHCODE-queryTeacherAgeNum");}
		return ta;
	}
	@Override
	public String[] queryTeacherWorkYearNum(String schyear, String academyN) {
		//工龄  工作年限  当前学年X  学院  ["3年以下", "3-5年", "5-10年", "10-20年", "20-50年", "50年以上"*/
		String[] ta=new String[]{"0","0","0","0","0","0"};
		try{
			String academyID = (String)this.bdpJdbcTemplate.queryForObject("select A.ID from ORG A where A.NAME = ?",new Object[]{academyN},String.class);
			String USER_TYPEID=this.mhJdbcTemplate.queryForObject("select A.ID from DIC_CATEGORY A where A.CODE = ? and A.STATUS = ? ", new Object[]{"USER_TYPE","1"},String.class);
			String TeaTypeId=this.mhJdbcTemplate.queryForObject("select A.ID from DIC A where A.CODE = ? and A.DIC_CATEGORY_ID = ? and A.STATUS = ? ", new Object[]{"TEACHER",USER_TYPEID,"1"},String.class);
			String STATUS=this.getDicID("ENABLE", "USER_STATUS");
			String DELETE_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql="select count(*) from B_USER A where A.USER_TYPE = ? "+ 
					" and A.ID in (select B.USER_ID from USER_LOGIN B where substr(B.LOGIN_NAME,0,4) <= ? "+
					        " and (to_char(sysdate,'yyyy')-substr(B.LOGIN_NAME,0,4)) BETWEEN ? AND ? ) "+
					" and A.ID in (select C.USER_ID from USER_ORG_POSITION C where C.ORG_ID = ? )"+
					" and A.STATUS = ? "+
					" and A.DELETE_STATUS = ? ";
			long s1=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,-200,2,academyID,STATUS,DELETE_STATUS});
			long s2=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,3,4,academyID,STATUS,DELETE_STATUS});
			long s3=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,5,9,academyID,STATUS,DELETE_STATUS});
			long s4=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,10,19,academyID,STATUS,DELETE_STATUS});
			long s5=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,20,49,academyID,STATUS,DELETE_STATUS});
			long s6=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,50,200,academyID,STATUS,DELETE_STATUS});
			ta[0]=s1+"";ta[1]=s2+"";ta[2]=s3+"";ta[3]=s4+"";ta[4]=s5+"";ta[5]=s6+"";
			//System.out.println(ta[0]+""+ta[1]+""+ta[2]+""+ta[3]+""+ta[4]+""+ta[5]+"");
			//System.out.println(academyN+" "+schyear+" "+academyID);
		}catch (Exception e) {/*e.printStackTrace();System.out.println("MHCODE-queryTeacherWorkYearNum");*/	}
		return ta;
	}
	@Override
	public List<String[]> queryTeacherNumBar(String schyear,List<String> academyList) {
		//某学年 不同学院  的在校教职工人数*/
		List<String[]> list=new ArrayList<String[]>();
		try {
			String[] OrgName = new String[academyList.size()];
			String[] TeaNum = new String[academyList.size()];
			String USER_TYPEID=this.mhJdbcTemplate.queryForObject("select A.ID from DIC_CATEGORY A where A.CODE = ? and A.STATUS = ? ", new Object[]{"USER_TYPE","1"},String.class);
			String TeaTypeId=this.mhJdbcTemplate.queryForObject("select A.ID from DIC A where A.CODE = ? and A.DIC_CATEGORY_ID = ? and A.STATUS = ? ", new Object[]{"TEACHER",USER_TYPEID,"1"},String.class);
			String STATUS=this.getDicID("ENABLE", "USER_STATUS");
			String DELETE_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql="select count(*) from B_USER A where A.USER_TYPE = ? "+ 
					" and A.ID in (select B.USER_ID from USER_LOGIN B where substr(B.LOGIN_NAME,0,4) <= ? )"+
					" and A.ID in (select C.USER_ID from USER_ORG_POSITION C where C.ORG_ID = ? )"+
					" and A.STATUS = ? "+
					" and A.DELETE_STATUS = ? ";
			for (int i = 0; i < academyList.size(); i++) {
				String thename="",thenum="0";
				thename=academyList.get(i);
				try{
					String academyID = (String)this.bdpJdbcTemplate.queryForObject("select A.ID from ORG A where A.NAME = ?",new Object[]{academyList.get(i)},String.class);
					long s1=(long)this.bdpJdbcTemplate.queryForLong(sql, new Object[]{TeaTypeId,schyear,academyID,STATUS,DELETE_STATUS});
					thenum=s1+"";}catch(Exception e){/*e.printStackTrace();*/}
				OrgName[i]=thename;	TeaNum[i]=thenum;
			}
			list.add(OrgName);list.add(TeaNum);
		} catch (Exception e) {	/*e.printStackTrace();*/}
		return list;
	}
	@Override
	public List<String[]> queryListforbar(String schyear,
			List<String> schyearList, List<String> academyList) {//目前从TC_XS_XSSFZZ取值【may】
		//[ ,,,,year-1]   [  ,,,,year ]   [ ,,,, year-1]
		String[] barlist=new String[academyList.size()+1];
		List<String[]> list=new ArrayList<String[]>();
		try{		
			int[] yy=new int[3];  int nowyear=Integer.parseInt(schyear);
			int size=schyearList.size();
			if(size<3){ list.add(barlist); list.add(barlist); list.add(barlist); return list;  }
			nowyear=nowyear>(Integer.parseInt(schyearList.get(1)))?(Integer.parseInt(schyearList.get(1))):nowyear;
			nowyear=nowyear<(Integer.parseInt(schyearList.get(size-2)))?(Integer.parseInt(schyearList.get(size-2))):nowyear;
			yy[0]=nowyear-1;yy[1]=nowyear;yy[2]=nowyear+1;
			int i=0;
			while( i >= size){
				if( yy[0]>=Integer.parseInt(schyearList.get(i))) {
					yy[0]=Integer.parseInt(schyearList.get(i));
					break;
				}else{
					i++;
				}
			}
			yy[1]=yy[0]+1;   yy[2]=yy[0]+2; 
			String sql="select count(distinct UPPER(rtrim(A.SFZH))) from TC_XS_XSSFZZ A where  A.RXND = ? and A.BMMC = ? ";
			//
//			String sql="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+ 
//					" A.ENTRY_DATE = ? "+ //入学学年
//					" and A.TEACH_INSTITUTION = ? "+ //组织机构 新版
//					" and A.DEL_STATUS = ? "; //删除状态
//			String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			//
			for (int j = 0; j < yy.length; j++) {
				String[] thelist=new String[academyList.size()+1];
				thelist[academyList.size()]=yy[j]+"";
				for (int j2 = 0; j2 < academyList.size(); j2++) {
					String academyN0=academyList.get(j2);
					//
					if("人文与设计学院".equals(academyN0)){academyN0="人文与艺术设计学院";}//【SPECIAL RULE】特殊规则
					thelist[j2]=""+(long)financeJdbcTemplate.queryForLong(sql, new Object[]{yy[j],academyN0});
					//
//					String ENTRY_DATE=this.getDicID(yy[j]+"", "ENTER_YEAR");
//					String academyORGID=this.getOrgID(academyN0);
//					thelist[j2]=""+(long)mhJdbcTemplate.queryForLong(sql, new Object[]{ENTRY_DATE,academyORGID,DEL_STATUS});
					//
				}
				list.add(thelist);
			}
		}catch (Exception e) {/*e.printStackTrace();*//*System.out.println("MHCODE-queryListforbar");*/	}
		return list;
	}
	@Override
	public String[] queryListforline(String schyear, List<String> schyearList,
			String academyN) {//目前从TC_XS_XSSFZZ取值【may】
		//指定院系 [年-1，年，年+1，值，值，值]
		int[] yy=new int[]{0,0,0};  long yy0=0,yy1=0,yy2=0;
		try{
			int nowyear=Integer.parseInt(schyear);
			int size=schyearList.size();
			if(size<3){return new String[]{"","","","","",""}; }
			nowyear=nowyear>(Integer.parseInt(schyearList.get(1)))?(Integer.parseInt(schyearList.get(1))):nowyear;
			nowyear=nowyear<(Integer.parseInt(schyearList.get(size-2)))?(Integer.parseInt(schyearList.get(size-2))):nowyear;
			yy[0]=nowyear-1;yy[1]=nowyear;yy[2]=nowyear+1;
			int i=0;
			while( i >= size){
				if( yy[0]>=Integer.parseInt(schyearList.get(i))) {
					yy[0]=Integer.parseInt(schyearList.get(i));
					break;
				}else{
					i++;
				}
			}
			yy[1]=yy[0]+1;   yy[2]=yy[0]+2; 
			String sql="select count(distinct UPPER(rtrim(A.SFZH))) from TC_XS_XSSFZZ A where  A.RXND = ? and A.BMMC = ?";
			//
//			String sql="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+ 
//					" A.ENTRY_DATE = ? "+ //入学学年
//					" and A.TEACH_INSTITUTION = ? "+ //组织机构 新版
//					" and A.DEL_STATUS = ? "; //删除状态
//			String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			//
			if("人文与设计学院".equals(academyN)){academyN="人文与艺术设计学院";}//【SPECIAL RULE】特殊规则
			yy0 = (Long)this.financeJdbcTemplate.queryForLong(sql, new Object[]{yy[0],academyN});
			yy1 = (Long)this.financeJdbcTemplate.queryForLong(sql, new Object[]{yy[1],academyN});
			yy2 = (Long)this.financeJdbcTemplate.queryForLong(sql, new Object[]{yy[2],academyN});
			//
//			String academyORGID=this.getOrgID(academyN);
//			yy0 = (Long)this.mhJdbcTemplate.queryForLong(sql, new Object[]{this.getDicID(yy[0]+"", "ENTER_YEAR"),academyORGID,DEL_STATUS});
//			yy1 = (Long)this.mhJdbcTemplate.queryForLong(sql, new Object[]{this.getDicID(yy[1]+"", "ENTER_YEAR"),academyORGID,DEL_STATUS});
//			yy2 = (Long)this.mhJdbcTemplate.queryForLong(sql, new Object[]{this.getDicID(yy[2]+"", "ENTER_YEAR"),academyORGID,DEL_STATUS});
			//
		}catch (Exception e) {/*e.printStackTrace();*//*System.out.println("MHCODE-queryListforline");*/}
		return new String[]{yy[0]+"",yy[1]+"",yy[2]+"",yy0+"",yy1+"",yy2+""};
	}
	@Override
	public int queryStuNoAll(String schyear, String academyN, List<String> academyList) {//目前从TC_XS_XSSFZZ取值【may】
		String sql="select count(distinct UPPER(rtrim(A.SFZH))) from TC_XS_XSSFZZ A where  A.RXND = ? and A.BMMC = ? ";
		//
//		String sql="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+ 
//				" A.ENTRY_DATE = ? "+ //入学学年
//				" and A.TEACH_INSTITUTION = ? "+ //组织机构 新版
//				" and A.DEL_STATUS = ? "; //删除状态
//		String ENTRY_DATE=this.getDicID(schyear, "ENTER_YEAR");
//		String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
		//
		long ZRS=0;
		for (int i = 0; i < academyList.size(); i++) {
			String theacademyN=academyList.get(i);
			if("人文与设计学院".equals(theacademyN)){theacademyN="人文与艺术设计学院";}//【SPECIAL RULE】特殊规则
			try{//所有有权限的学院
				ZRS += (Long)this.financeJdbcTemplate.queryForLong(sql, new Object[]{schyear,theacademyN});
				//
//				ZRS += (Long)this.mhJdbcTemplate.queryForLong(sql, new Object[]{ENTRY_DATE,this.getOrgID(theacademyN),DEL_STATUS});
				//	
			}catch (Exception e) {}
		}
		return (int)ZRS;
	}
	@Override
	public String[] queryStuSexRate(String schyear, String academyN) {
		//男女比 [男 男比 女 女比]比例为 百分制 入学学年
		String[] sex=new String[]{"0","0","0","0"};
		try{
			String academyORGID=this.getOrgID(academyN);
			String GENDER_IDNan =this.getDicID("MALE", "GENDER");
			String GENDER_IDNv  =this.getDicID("FEMALE", "GENDER");
			String ENTRY_DATE=this.getDicID(schyear, "ENTER_YEAR");
			String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql33="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+ 
							" A.TEACH_INSTITUTION = ? "+ //组织机构 新版
							" and A.ENTRY_DATE = ? "+ 
							" and A.GENDER = ? "+ 
							" and A.DEL_STATUS = ? ";
			double y0 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33, new Object[]{academyORGID,ENTRY_DATE,GENDER_IDNan,DEL_STATUS});
			double y2 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33, new Object[]{academyORGID,ENTRY_DATE,GENDER_IDNv,DEL_STATUS});
			double zong=y0+y2,y1=0,y3=0;
			if(zong!=0.0){y1=y0/zong; y3=y2/zong;}
			DecimalFormat df=new DecimalFormat("#0.#");  
			sex[0]=""+(int)y0; 
			sex[1]=""+df.format(y1*100).toString();
			sex[2]=""+(int)y2; 
			sex[3]=""+df.format(y3*100).toString();
			//System.out.println("sex:"+sex[0]+" "+sex[1]+" "+sex[2]+" "+sex[3]); 
			//System.out.println(schyear+" "+academyN+" "+GENDER_IDNan+" "+GENDER_IDNv+" "+academyORGID);
		}catch(Exception e){e.printStackTrace();/*System.out.println("MHCODE-queryStuSexRate");*/}
		return sex;
	}
	@Override
	public String[] queryStuEnrollment(String schyear, String academyN) {
		// 招生方式  [统招4028811d56d412d50156d426f5ca000a  统招比  单招4028811d56d412d50156d428520f000b  单招比]*/
		String[] zhaoshen=new String[]{"0","0","0","0"};
		try{//待定
			String DANZHAO=this.getDicID("WEL_DANZHAO", "SOURCE_TYPE");//单招
			String WEL_DUIKOU=this.getDicID("WEL_DUIKOU", "SOURCE_TYPE");//对口单招
			//String TongZHAO=this.getDicID("WEL_DANZHAO", "SOURCE_TYPE");//4028811d56d412d50156d426f5ca000a
			String academyORGID=this.getOrgID(academyN);
			String ENTRY_DATE=this.getDicID(schyear, "ENTER_YEAR");
			String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql33="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+
					" A.TEACH_INSTITUTION = ? "+
					" and A.ENTRY_DATE = ? "+
					" and A.DEL_STATUS = ? ";
			double y0 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33+"and (A.STUDENTS_TYPE != ? and A.STUDENTS_TYPE != ?)", 
					new Object[]{academyORGID,ENTRY_DATE,DEL_STATUS,DANZHAO,WEL_DUIKOU});//统招
			double y2 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33+"and (A.STUDENTS_TYPE  = ? or A.STUDENTS_TYPE  = ?)", 
					new Object[]{academyORGID,ENTRY_DATE,DEL_STATUS,DANZHAO,WEL_DUIKOU});//单招
			double zong=y0+y2,y1=0,y3=0;
			if(zong!=0.0){y1=y0/zong; y3=y2/zong;}
			zhaoshen[0]=""+(long)y0; zhaoshen[1]=""+y1*100; zhaoshen[2]=""+(long)y2; zhaoshen[3]=""+y3*100;	
		}catch(Exception e){e.printStackTrace();/*System.out.println("MHCODE-queryStuEnrollment");*/}
		return zhaoshen;
	}
	@Override
	public String[] queryStuOriginPlace(String schyear, String academyN) {
		//** 生源地     [河南  其他] */ SOURCE_PROVINCES
		String[] shenyuan=new String[]{"0","0"};
		try{
			String DANZHAO=this.getDicID("WEL_DANZHAO", "SOURCE_TYPE");
			String academyORGID=this.getOrgID(academyN);
			String ENTRY_DATE=this.getDicID(schyear, "ENTER_YEAR");
			String DEL_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql33="select count(distinct A.STUDENT_ID) from STU_STUDENT_BASEINFO A where "+
					" A.TEACH_INSTITUTION = ? "+
					" and A.ENTRY_DATE = ? "+
					" and A.DEL_STATUS = ? ";
			double y0 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33+"and A.SOURCE_PROVINCES = ?", 
					new Object[]{academyORGID,ENTRY_DATE,DEL_STATUS,"410000"});
			double y1 = (Long)this.schoolRollJdbcTemplate.queryForLong(sql33+"and A.SOURCE_PROVINCES IS NOT NULL and A.SOURCE_PROVINCES != ? ", 
					new Object[]{academyORGID,ENTRY_DATE,DEL_STATUS,"410000"});
			shenyuan[0]=""+y0; shenyuan[1]=""+y1; 
		}catch(Exception e){e.printStackTrace();/*System.out.println("MHCODE-queryStuOriginPlace");*/}
		return shenyuan;
	}
	@Override
	public List<MHstatistStudentTuition> queryMHstuFeeList(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,List<String> academyList) {
		//当前学年X  学院 List [院系名称,总人数,总缴费状态,总[完全缴,未缴,部分缴],学[完,未,部分],教材[完,未,部分],住宿[完,未,部分]]
		String sql="select count(distinct UPPER(rtrim(A.SFZH))) from TC_XS_XSSFZZ A where A.BMMC = ? and A.SFQJDM = ? and A.SFXMMC LIKE ? ";
		for (int i = 0; i < academyList.size(); i++) {//有多少院 做多少循环
			MHstatistStudentTuition mh=new MHstatistStudentTuition();
			long ZRS=0,WQJF=0,WJF=0,BFJF=0,WQJF1=0,WJF1=0,BFJF1=0,WQJF2=0,WJF2=0,BFJF2=0,WQJF3=0,WJF3=0,BFJF3=0;
			long WQJF1_0=0, WJF1_0=0, BFJF1_0=0;//变量初始化
			String academyN0=academyList.get(i);//获取学院名称
			mh.setXYMC(academyN0);//赋值
			if("人文与设计学院".equals(academyN0)){academyN0="人文与艺术设计学院";}//【SPECIAL RULE】特殊规则
			try{/*查询 学费[完,未,部分]*/
				WQJF1= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE <= 0 ", new Object[]{academyN0,schyear,"%学费%"});
				WJF1 = (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE = A.YJJE and A.YJJE > 0 ", new Object[]{academyN0,schyear,"%学费%"});
				BFJF1= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE < A.YJJE and A.QFJE > 0 ", new Object[]{academyN0,schyear,"%学费%"});}catch(Exception e){}
			try{//特殊学费字段
				WQJF1_0= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE <= 0 ", new Object[]{academyN0,schyear,"%普通中专（含中师）%"});
				WJF1_0 = (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE = A.YJJE and A.YJJE > 0 ", new Object[]{academyN0,schyear,"%普通中专（含中师）%"});
				BFJF1_0= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE < A.YJJE and A.QFJE > 0 ", new Object[]{academyN0,schyear,"%普通中专（含中师）%"});
				WQJF1+=WQJF1_0;  WJF1+=WJF1_0; BFJF1+=BFJF1_0;}catch(Exception e){}
			try{/*查询 教材[完,未,部分]*/
				WQJF2= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE <= 0 ", new Object[]{academyN0,schyear,"%教材费%"});
				WJF2 = (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE = A.YJJE and A.YJJE > 0 ", new Object[]{academyN0,schyear,"%教材费%"});
				BFJF2= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE < A.YJJE and A.QFJE > 0 ", new Object[]{academyN0,schyear,"%教材费%"});}catch(Exception e){}
			try{/*查询 住宿[完,未,部分]*/
				WQJF3= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE <= 0 ", new Object[]{academyN0,schyear,"%住宿费%"});
				WJF3 = (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE = A.YJJE and A.YJJE > 0 ", new Object[]{academyN0,schyear,"%住宿费%"});
				BFJF3= (long)financeJdbcTemplate.queryForLong(sql+"and  A.QFJE < A.YJJE and A.QFJE > 0 ", new Object[]{academyN0,schyear,"%住宿费%"});}catch(Exception e){}
			/*计算总值*/
			try{/*查询 上述三者[完,未,部分]*/
				String sqlHard="select count(*) from (select UPPER(rtrim(A.SFZH)) ,SUM(A.YJJE) NYJJE,sum(A.QFJE) NQFJE "+
								"from TC_XS_XSSFZZ A where A.BMMC = ? and A.SFQJDM = ? "+
								"and (A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? OR A.SFXMMC LIKE ?)"+
								"GROUP BY UPPER(rtrim(A.SFZH))  ) BB WHERE ";
				WQJF= (long)financeJdbcTemplate.queryForLong(sqlHard+" BB.NQFJE <= 0 ", new Object[]{academyN0,schyear,"%学费%","%普通中专（含中师）%","%教材费%","%住宿费%"});
				WJF = (long)financeJdbcTemplate.queryForLong(sqlHard+" BB.NQFJE = BB.NYJJE and BB.NYJJE > 0 ", new Object[]{academyN0,schyear,"%学费%","%普通中专（含中师）%","%教材费%","%住宿费%"});
				BFJF= (long)financeJdbcTemplate.queryForLong(sqlHard+" BB.NQFJE < BB.NYJJE and BB.NQFJE > 0 ", new Object[]{academyN0,schyear,"%学费%","%普通中专（含中师）%","%教材费%","%住宿费%"});
			}catch (Exception e) {}
			mh.setWQJF((int)WQJF);			mh.setWJF((int)WJF);			mh.setBFJF((int)BFJF);
			ZRS=WQJF+WJF+BFJF;				mh.setZRS((int)ZRS);						          
			mh.toaddJFZT();//赋值顺序不能改变
			mh.setWQJF1((int)WQJF1);			mh.setWJF1((int)WJF1);			mh.setBFJF1((int)BFJF1);  
			mh.setWQJF2((int)WQJF2);			mh.setWJF2((int)WJF2);			mh.setBFJF2((int)BFJF2);  
			mh.setWQJF3((int)WQJF3);			mh.setWJF3((int)WJF3);			mh.setBFJF3((int)BFJF3);  
			mHstuFeeList.add(mh);
		}
		return mHstuFeeList;
	}
	/**按DIC_CODE、DIC_CATEGORY_CODE 查询可用 dic 的id*/
	public String getDicID(String DIC_CODE,String DIC_CATEGORY_CODE) {/*内部工具类*/
		String id="";
		String sql="select A.ID from DIC A where A.CODE= ? and A.STATUS= ? and A.DIC_CATEGORY_ID in "+
				"(select B.ID from DIC_CATEGORY B where B.CODE = ? and B.STATUS = ? )";
		try{
			id=this.mhJdbcTemplate.queryForObject(sql, new Object[]{DIC_CODE,"1",DIC_CATEGORY_CODE,"1"},String.class);}catch(Exception e){};
		return id;
	}
	/**按name查询启用状态的org*/
	public String getOrgID(String NAME) {/*内部工具类*/
		String id="";
		String sql="select A.ID from ORG A where A.NAME = ? and A.STATUS = ? ";
		try{
			String STATUS=this.getDicID("ENABLE", "STATUS_ENABLE_DISABLE");
			id=this.mhJdbcTemplate.queryForObject(sql, new Object[]{NAME,STATUS},String.class);}catch(Exception e){};
		return id;
	}
	//---------------------------------------------------------------------------------//
	@Override
	//F
	public MhTeacherUser getMhSuperUser(String userId) {//方法已经无用 废弃代码
		MhTeacherUser mhs=new MhTeacherUser();
		return mhs;
	}
	//F
	public MhTeacherUser isMhTeacherUserExist(String userId){//方法已经无用 废弃代码
		MhTeacherUser mhs=new MhTeacherUser();
		return null;
	}
	@Override
	public List<MHstatistStudentTuition> queryMHstuFeeList2(String schyear,
			String academyN, List<MHstatistStudentTuition> mHstuFeeList,List<String> academyList) {
		return mHstuFeeList;
	}
}
