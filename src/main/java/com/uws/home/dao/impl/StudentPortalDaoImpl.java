package com.uws.home.dao.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.uws.core.hibernate.dao.impl.BaseDaoImpl;
import com.uws.home.dao.StudentPortalDao;
import com.uws.home.model.MhStuUser;
import com.uws.home.model.MhStuUserTuition;
@Repository
public class StudentPortalDaoImpl extends BaseDaoImpl implements StudentPortalDao{
	//自身平台
	@Resource(name = "mhJdbcTemplate")
	private JdbcTemplate mhJdbcTemplate;
	//财务
	@Resource(name="financeJdbcTemplate")
	private JdbcTemplate financeJdbcTemplate;//正式版需要修改 financeJdbcTemplate 门户放入TC_XS_XSSFZZ 就可以
	//学生
	@Resource(name = "mhJdbcTemplate")
	private JdbcTemplate schoolRollJdbcTemplate ;//学工库 已经在门户  必要时修改为学工库
	//学生目前使用的是 XH  目前指的是身份证号 匹配时使用大写匹配  
	@Override
	public MhStuUser getMhStuUser(String UserId) {
		MhStuUser mhs=new MhStuUser();//因为系统已经认可登录用户 所以可以不进行B_USER状态删除判断
		mhs.setXH(UserId);
		String XM="",SFZH="",XYMC="";
			Calendar cal = Calendar.getInstance();	
			int nowYear = cal.get(Calendar.YEAR); 
			int nowMon = cal.get(Calendar.MONTH)+1;
			nowYear=(nowMon<=8)?nowYear-1:nowYear;
		mhs.setNowYear(nowYear+"");//设置默认当前学年
		try{
			XM=mhJdbcTemplate.queryForObject("select A.NAME from B_USER A where A.ID = ? ", new Object[]{UserId},String.class);		
		}catch(Exception e){}
		mhs.setXM(XM);//从 B_USER 获取姓名
		try{
			SFZH=mhJdbcTemplate.queryForObject("select A.CERT_NUM from B_USER A where A.ID = ? ", new Object[]{UserId},String.class);		
		}catch(Exception e){}
		mhs.setSFZH(SFZH);// 从 B_USER 获取身份证号[才能与学生表获取关联]	
		try{
			List<Map<String, Object>> list=this.financeJdbcTemplate.queryForList("select A.BMMC from TC_XS_XSSFZZ A where UPPER(rtrim(A.SFZH)) = ? ", new Object[]{SFZH.toUpperCase()});//争议	
			Iterator iterator = list.iterator();//这里注意   换了数据库 并且对方库的 XH 放的其实是身份证号
	        while (iterator.hasNext()) {
	            Map map4book = (Map) iterator.next();
	            XYMC=(String) map4book.get("BMMC");
	            if("人文与艺术设计学院".equals(XYMC)){XYMC="人文与设计学院";}//【SPECIAL RULE】特殊规则
	            break;
	        }//只取一行
		}catch(Exception e){}
		mhs.setBMMC(XYMC);// 从 TC_XS_XSSFZZ  获取学生用户所在学院名称 为空 或者 有1个[]
		try{
			String sql="select RXND,LXND from TC_XS_XSSFZZ A where UPPER(rtrim(A.SFZH)) = ?";//争议
			List<Map<String, Object>>  list=this.financeJdbcTemplate.queryForList(sql,SFZH.toUpperCase());
			Iterator<Map<String, Object>> iterator = list.iterator();
	        while (iterator.hasNext()) {
	            Map map4book = (Map) iterator.next();            
	            mhs.setRXND((String) map4book.get("RXND"));            
	            mhs.setLXND((String) map4book.get("LXND"));
	            break;
	        }//只取一行
		}catch(Exception e){}
		return mhs;
	}
	@Override
	public String getMhStuCurrentFee(String xH, String yuanxi) {
		Double fee=0.0;//yuanxi似乎没用
		Calendar cal = Calendar.getInstance();
		int nowYear = cal.get(Calendar.YEAR);
		int nowMon = cal.get(Calendar.MONTH)+1;
		nowYear=(nowMon<=8)?nowYear-1:nowYear;
		try{
			String sql="SELECT * FROM TC_XS_XSSFZZ A WHERE UPPER(rtrim(A.SFZH)) = ? AND A.SFQJDM = ? " +
					"AND ( A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? ) ";//争议
			List<Map<String, Object>> list=this.financeJdbcTemplate.queryForList(sql,xH.toUpperCase(),nowYear,"%学费%","%普通中专（含中师）%","%教材费%","%住宿费%");//★★
			Iterator iterator = list.iterator();
	        while (iterator.hasNext()) {
	            Map map4book = (Map) iterator.next();
	            fee=fee+((BigDecimal)map4book.get("SJJE")).doubleValue();//累加
	        }//只取一行
		}catch(Exception e){}
		return fee+"";
	}
	@Override
	public String isTeaOrStu(String userId) {
		/*使用表 DIC_CATEGORY  DIC  B_USER 这边只判断是否存在 不进行状态判断*/
		long Teashumu=0,Stushumu=0,superusermu=0;
		try{
			String TeaTypeId=this.getDicID("TEACHER", "USER_TYPE");  
			String StuTypeId=this.getDicID("STUDENT", "USER_TYPE");
			String sql00="select count(*) from B_USER A where A.USER_TYPE = ? and A.ID = ? ";//ENABLE DISABLE
			Teashumu=(long)this.mhJdbcTemplate.queryForLong(sql00, new Object[]{TeaTypeId,userId});
		    Stushumu=(long)this.mhJdbcTemplate.queryForLong(sql00, new Object[]{StuTypeId,userId});
			String sql01="select count(*) from B_USER A where A.IS_SUPERUSER = ? and A.ID = ? ";
			superusermu=(long)this.mhJdbcTemplate.queryForLong(sql01, new Object[]{"1",userId});
		}catch(Exception e){e.printStackTrace();/*System.out.println("MHCODE-isTeaOrStu-Err");*/}
		if(superusermu > 0){
			return "SYS";
		}
		if(Teashumu >0 && Stushumu <=0){
			return "TEA";
		}
		if(Stushumu >0 && Teashumu <=0 ){
			return "STU";
		}
		return "";
	}
	@Override
	public List<String[]> getMhStuRelatedTea(MhStuUser stuUser) {
		List<String[]> PingTeaIDS=new ArrayList<String[]>();
		try {
			String TeaTypeId=this.getDicID("TEACHER", "USER_TYPE");
			String STATUS=this.getDicID("ENABLE", "USER_STATUS");
			String DELETE_STATUS=this.getDicID("NORMAL", "STATUS_NORMAL_DELETED");
			String sql1="select ID,NAME from B_USER A where A.USER_TYPE = ? " +
					" and A.STATUS = ? "+
					" and A.DELETE_STATUS = ? "+
					" ORDER BY A.CREATE_TIME ASC";
			List list=this.mhJdbcTemplate.queryForList(sql1,new Object[]{ TeaTypeId,STATUS,DELETE_STATUS});//管理员需 过滤掉
			Iterator iterator1 = list.iterator();
			if(list.size()<=0){return PingTeaIDS;}
			String[] Ids=new String[list.size()];
			String[] Names=new String[list.size()];
			int i=0;
			while (iterator1.hasNext()) {
				Map map4book = (Map) iterator1.next();
				Ids[i]  =(String) map4book.get("ID");
				Names[i]=(String) map4book.get("NAME");
				i++;
			}//取多行
			PingTeaIDS.add(Ids);
			PingTeaIDS.add(Names);
		}catch(Exception e){}
		return PingTeaIDS;
	}
	@Override
	public MhStuUserTuition getMhStuTuition(String XH, String year) {
		MhStuUserTuition mst=new MhStuUserTuition();
		try{
			String sql="select A.YJJE,A.SJJE,A.JMJE,A.QFJE from TC_XS_XSSFZZ A where UPPER(rtrim(A.SFZH)) = ? and A.SFQJDM = ? and ";
			List list1=this.financeJdbcTemplate.queryForList(sql+" (A.SFXMMC LIKE ? OR A.SFXMMC LIKE ? )", XH.toUpperCase(),year,"%学费%","普通中专（含中师）");//★★
			List list2=this.financeJdbcTemplate.queryForList(sql+" A.SFXMMC LIKE ? ", XH.toUpperCase(),year,"%教材费%");//★★
			List list3=this.financeJdbcTemplate.queryForList(sql+" A.SFXMMC LIKE ? ", XH.toUpperCase(),year,"%住宿费%");//★★
			Iterator iterator1 = list1.iterator();
			Iterator iterator2 = list2.iterator();
			Iterator iterator3 = list3.iterator();	 
			BigDecimal Y=new BigDecimal(0.0);
			BigDecimal S=new BigDecimal(0.0);
			BigDecimal J=new BigDecimal(0.0);
			BigDecimal Q=new BigDecimal(0.0);
			while (iterator1.hasNext()) {
				Map cc = (Map) iterator1.next();
				Y=Y.add( (BigDecimal)cc.get("YJJE") );
				S=S.add( (BigDecimal)cc.get("SJJE") );
				J=J.add( (BigDecimal)cc.get("JMJE") );
				Q=Q.add( (BigDecimal)cc.get("QFJE") );
			}
			mst.setYJ1(Y); 
			mst.setSJ1(S);
			mst.setJM1(J);
			mst.setQF1(Q);	Y=new BigDecimal(0);S=new BigDecimal(0);J=new BigDecimal(0);Q=new BigDecimal(0);
			while (iterator2.hasNext()) {
				Map cc = (Map) iterator2.next();
				Y=Y.add( (BigDecimal)cc.get("YJJE") );
				S=S.add( (BigDecimal)cc.get("SJJE") );
				J=J.add( (BigDecimal)cc.get("JMJE") );
				Q=Q.add( (BigDecimal)cc.get("QFJE") );
			}
			mst.setYJ2(Y); 
			mst.setSJ2(S);
			mst.setJM2(J);
			mst.setQF2(Q);	Y=new BigDecimal(0);S=new BigDecimal(0);J=new BigDecimal(0);Q=new BigDecimal(0);
			while (iterator3.hasNext()) {
				Map cc = (Map) iterator3.next();
				Y=Y.add( (BigDecimal)cc.get("YJJE") );
				S=S.add( (BigDecimal)cc.get("SJJE") );
				J=J.add( (BigDecimal)cc.get("JMJE") );
				Q=Q.add( (BigDecimal)cc.get("QFJE") );
			}
			mst.setYJ3(Y); 
			mst.setSJ3(S);
			mst.setJM3(J);
			mst.setQF3(Q);	
			mst.setYear(year);
			mst.sumAll();   //对数据赋汇总值
			mst.theState(); //把缴费状态也算一下
		}catch(Exception e){e.printStackTrace();}
		return mst;
	}
	/**按DIC_CODE、DIC_CATEGORY_CODE 查询可用 dic 的id*/
	public String getDicID(String DIC_CODE,String DIC_CATEGORY_CODE) {/*内部工具类*/
		String id="";
		String sql="select A.ID from DIC A where A.CODE= ? and A.STATUS= ? and A.DIC_CATEGORY_ID in "+
				"(select B.ID from DIC_CATEGORY B where B.CODE = ? and B.STATUS = ? )";
		try{
			id=this.mhJdbcTemplate.queryForObject(sql, new Object[]{DIC_CODE,"1",DIC_CATEGORY_CODE,"1"},String.class);
		}catch(Exception e){e.printStackTrace();};
		return id;
	}
	/**查询身份证为 sfz的学生本月未签到次数 */
	@Override
	public String getMhStuNotSign(String sfz) {
		String result="0";
		String REGISTER_STATUS=getDicID("SMARTREGISTER_STATUS_NO","SMARTREGISTER_STATUS");
		if("".equals(REGISTER_STATUS)){return "0";}
		String sql="SELECT COUNT(*) FROM STU_REGISTE_RECORD A "+
				" LEFT JOIN STU_STUDENT_BASEINFO B ON A.STUDENT = B.ID " +
				" WHERE B.ID_NUMBER= ? "+
				" AND A.REGISTER_STATUS = ? "+
				" AND A.CREATE_TIME > to_date(?,'yyyy-mm-dd') "+
				" AND A.CREATE_TIME < to_date(?,'yyyy-mm-dd HH24:mi:SS') ";
        Calendar calendar1 = Calendar.getInstance();
        Calendar calendar2 = Calendar.getInstance();
        calendar1.set(Calendar.DATE, calendar1.getActualMaximum(Calendar.DATE));//最后1天
		calendar2.set(Calendar.DAY_OF_MONTH,1);//第一天
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String ss1=format.format(calendar1.getTime());
		String ss2=format.format(calendar2.getTime());
		try{
			long result2=this.mhJdbcTemplate.queryForLong(sql, new Object[]{sfz,REGISTER_STATUS,ss2,ss1+" 23:59:59"});result=result2+"";
		}catch(Exception e){};
		return result;
	}
}
