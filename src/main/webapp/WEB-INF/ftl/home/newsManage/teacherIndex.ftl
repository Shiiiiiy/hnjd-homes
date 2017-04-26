<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/teacher.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    <link href='${rc.contextPath}/css/fullcalendar.css' rel='stylesheet' />
    <link href='${rc.contextPath}/css/fullcalendar.print.css' rel='stylesheet' media='print' />
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/bootstrap.min.css">
    <script type="text/javascript" src='${rc.contextPath}/js/moment.min.js'></script>
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src='${rc.contextPath}/js/fullcalendar.min.js'></script>
    <script type="text/javascript" src='${rc.contextPath}/js/slider.js'></script>
    <!--系统psd组件 -->
    <link rel="stylesheet" href="${rc.contextPath}/css/bdp_comp.css" type="text/css">
    <script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
	<script src="${rc.contextPath}/lib/jquery-ui/jquery-ui-1.8.20.custom.min.js"></script>
	<script src="${rc.contextPath}/js/jquery.form.js"></script>
    <script src="${rc.contextPath}/js/jquery.metadata.js"></script>
    <script src="${rc.contextPath}/js/myjs_message_cn.js"></script>
    <script src="${rc.contextPath}/js/bdp_comp.js"></script>
	<script src="${rc.contextPath}/lib/My97DatePicker/WdatePicker.js"></script>
	<script src="${rc.contextPath}/js/bdp_fileupload.progressbar.js"></script>
	<script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
	<script src="${rc.contextPath}/lib/ztree/js/jquery.ztree.all-3.5.js"></script>
	<script src="${rc.contextPath}/lib/sticky/sticky.min.js"></script>
	<link rel="stylesheet" href="${rc.contextPath}/lib/sticky/sticky.css" />  
	<script src="${rc.contextPath}/lib/bootbox4/bootbox_custom.js"></script>  
	<!--系统psd组件End -->
    <title>教师门户</title>
</head>
<body>
<style>
/*系统密码样式*/
.mypassw_box {z-index:99999;left:50%; height:240px; padding-right:0!important;}
.mypassw_box .modal-header {padding:0;}
.mypassw_box .modal-header h3{font-size:16px;font-weight:bold;background:#f5f5f5; margin:0;padding:10px 15px;}
.mypassw_box .modal-header .close{margin-top:7px;}
.mypassw_box .row-fluid {padding:5px 0;}
.mypassw_box .modal-footer{padding:10px 15px;}
.mypassw_box .row-fluid label{font-weight:normal;color:red;display:inline;line-height:18px;margin-left:5px;}
.modal-backdrop, .modal-backdrop.fade.in{opacity: .2;filter:alpha(opacity=20);}
</style>
    <!--header-->
    <#-- 修改密码弹出框  默认是隐藏的 begin-->
    <div class="modal fade mypassw_box" id="changepasswordbox" style="">
		<div class="modal-header">
			<button class="close" data-dismiss="modal">×</button>
			<h3 id="title1">修改密码</h3>
		</div>
		<div class="modal-body">
			<#include "/user/user/changePassword.ftl">
		</div>
		<div class="modal-footer">
			<a href="#" class="btn btn" data-dismiss="modal">取消</a>
			<a href="#" class="btn btn-info" onclick="changePasswordSubmit()">确定</a>
		</div>
    </div>
    <#-- 修改密码弹出框  End-->
    <div class="header w clearfix">
        <div class="container">
            <div class="pull-left"><img src="${rc.contextPath}/css/images/logo.png" alt="" /></div>
            <div class="pull-right">
                <div id="localtime" class="f14 ml20 white fl hidden-xs"></div>
                <div class="fl dropdown ml30">
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i> ${(login_userName)!""}<i class="caret"></i></a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                        	<a href="javascript:changePassword()">修改密码</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="<#if login_userType?? && login_userType=='STUDENT'>${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do<#elseif  login_userType?? && login_userType=='TEACHER' && login_isSuperUser?? && login_isSuperUser='1'>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do?superuser=true<#else>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do</#if>">主页</a>
                        </li>	
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="${rc.contextPath}/logout.do">退出</a>  
                        </li>
                    </ul>
                </div>
                <div class="fl"><#if configManage?? && configManage=="ok"><a href="javascript:void(0);" onclick="showOrhide()" title="设置"><i class="iconfont  f20 white ml20 custom-but">&#xe605;</i></a></#if><#if permManage?? && permManage=="ok"><a title="角色管理" href="${rc.contextPath}/menhu/opt-query/queryRoleList.do"><i class="iconfont f20 white ml20">&#xe60f;</i></a></#if></div>
            </div>
        </div>
    </div>
    <div class="custom w" style="display:none;" id="myconfig">
        <div class="container" >
            <div class="row clearfix" >
                <ul id="configMenu">
                  <#if allMenu??>
                    <#list allMenu as au>
                          <#if au??>
                          
                               <li class="col-xs-12 col-sm-3 col-md-3 col-lg-2 "><a href="javascript:;"  name="${(au.id)!''}"  <#if au.mhMenuLevel?? && au.mhMenuLevel==-1>class="current"</#if>>${(au.mhMenuName)!""}</a></li>
                         
                          </#if>
                    </#list>
                  </#if>  
                </ul>
            </div>
            <p class="tr"><input type="button" class="close-btn" value="清空选择" onclick="clearMenu()"/><input type="button" class="submit-btn" value="保存" onclick="saveMneu()"/></p>
        </div>
    </div>
    <div class="container mb50">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 teacher-list">
                <h2>应用</h2>
                <!--news-->
                <!--<div class="news">
                    <ul>
                     <#if mhNewslist??>
                       <#list mhNewslist as nsl>
	                        <li><a href="${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId=${(nsl.id)!''}&newStat=A"><span><#if nsl??>${(nsl.updateTime)?string("MM-dd")}</#if></span>${((nsl.mhNewsTitle)!"")?html}</a></li>
                       </#list>
                     </#if>  
                    </ul>
                    <p class="tr"><a href="${rc.contextPath}/menhu/opt-query/queryNewsList.do">更多新闻公告&gt;&gt;</a></p>
                </div> 隐藏新闻板块-->
                <!--application-->
                <div class="row  teacher-box"><!--去掉pt10-->
                 <#if menuList??>   
                  <#list menuList as ml>  
                     <#if ml?? && ml.mhMenuOrder gt 0>
		                    <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4 teacher-list">
		                        <#if ml.mhMenuCode=="PAY" >
			                        <div class="square-box backcolor1">
			                            <a href="${rc.contextPath}/teacherPortal/opt-query/teacherDetailsFrame.do?menuParam=active1"><img src="${rc.contextPath}/css/images/icon-pay.png" alt="${(ml.mhMenuName)!''}" class="pic" /><p class="txt">${(ml.mhMenuName)!''}</p></a>
			                        </div>
		                        <#elseif ml.mhMenuCode=="STUDENTINFO">
		                            <div class="square-box backcolor2">
			                            <a href="${rc.contextPath}/teacherPortal/opt-query/teacherDetailsFrame.do?menuParam=active2"><img src="${rc.contextPath}/css/images/icon-student.png" alt="${(ml.mhMenuName)!''}" class="pic" /><p class="txt">${(ml.mhMenuName)!''}<span class="num hidden-md">${(StuNoAll!'0')?string(',###')}<b class="f14">人</b></span></p></a>
			                        </div>
		                        
		                        <#elseif ml.mhMenuCode=="TEACHERINFO">
		                            <div class="square-box backcolor3">
			                            <a href="${rc.contextPath}/teacherPortal/opt-query/teacherDetailsFrame.do?menuParam=active3">
			                                <div class="infor" >
			                                    <p class="infor-con"><i class="circle mr20">教师</i><b class="f14"></b></p>
			                                    <p class="infor-con mt20" style="display:none;"><i class="circle mr20"></i><b class="f14"></b></p>
			                                </div>
			                            <p class="txt">${(ml.mhMenuName)!''}</p>
			                            </a>
			                        </div>
		                        <#elseif ml.mhMenuCode=="CARDINFO">
		                                <a href="http://www.hnjd.edu.cn" target="_blank">
				                            <div class="rectangle-box backcolor4 building" id="rectangleBox">
				                                <div class="teacher-icon icon1"></div>
				                                <p class="txt">一卡通信息</p>
				                            </div>
				                        </a>
				               <#elseif ml.mhMenuCode=="TEACH_RESOURCE"> 
				                        <a href="http://192.168.190.17:9089/rodrcm" target="_blank">
				                            <div class="rectangle-box backcolor5" id="rectangleBox">
				                                <div class="teacher-icon icon2"></div>
				                                <p class="txt">教学资源<br />使用情况</p>
				                            </div>
				                        </a>
				               <#elseif ml.mhMenuCode=="DEPARTMENT"> 
				                    <a href="http://www.hnjd.edu.cn" target="_blank">
			                            <div class="rectangle-box backcolor6 building" id="rectangleBox">
			                                <div class="teacher-icon icon3"></div>
			                                <p class="txt">部门资产</p>
			                            </div>
			                        </a>
			                   <#elseif ml.mhMenuCode=="BOOK">
			                        <a href="http://www.hnjd.edu.cn" target="_blank">
			                            <div class="rectangle-box backcolor7 building" id="rectangleBox">
			                                <div class="teacher-icon icon4"></div>
			                                <p class="txt">图书借阅</p>
			                            </div>
			                        </a>
			                   <#elseif ml.mhMenuCode=="COURSE">      
			                        <a href="http://www.hnjd.edu.cn" target="_blank">
			                            <div class="rectangle-box backcolor8 building" id="rectangleBox" >
			                                <div class="teacher-icon icon5"></div>
			                                <p class="txt">课表查询</p>
			                            </div>
			                        </a>
			                   <#elseif ml.mhMenuCode=="STUDENT_CHECK">        
			                           <a href="http://192.168.190.14:9088/smartRegister/smartregister/editregister/toEditSmartRegisterUI.do" target="_blank">
				                            <div class="rectangle-box backcolor9">
				                                <div class="teacher-icon icon6"></div>
				                                <p class="txt">学生考勤信息</p>
				                            </div>
				                        </a>
			                   <#elseif ml.mhMenuCode=="TEACHING">    
			                            <a href="http://www.hnjd.edu.cn" target="_blank"><!--没有上线 10-24--->
				                            <div class="rectangle-box backcolor10 building" id="rectangleBox">
				                                <div class="teacher-icon icon7"></div>
				                                <p class="txt">教务系统</p>
				                            </div>
				                        </a>
										
				              <#elseif ml.mhMenuCode=="STUDENT_MANAGE">          
				                         <a href="http://192.168.190.14:9086/uws-stu/stusys/portalpage/main.do" target="_blank"><!-- 这个就保持这样  -->
				                            <div class="rectangle-box backcolor11">
				                                <div class="teacher-icon icon8"></div>
				                                <p class="txt">学生管理</p>
				                            </div>
				                        </a>
				              <#elseif ml.mhMenuCode=="OFFICE_OA">           
						               
				                        <a href="javascript:void(0);" onclick="javascript:$('#wang01').submit();">
										  <div class="rectangle-box backcolor12">
										  <div class="teacher-icon icon9"></div>
										  <p class="txt">办公OA</p>
										    <form style="display:none;" target="_blank" method="post" action="http://oa.hnjdxy.cn:8081/jsoa/lhydCheckUser.do" id="wang01">
										      <input type="text" name="userName" value="${(userName)!''}"/>
										    </form>
										  </div>
										</a>
				              <#elseif ml.mhMenuCode=="SCHOOL_ROLL"> 
				                        <a href="http://192.168.190.14:9084/edu2/main.do" target="_blank">
						                    <div class="rectangle-box backcolor13">
						                        <div class="teacher-icon icon18"></div>
						                        <p class="txt">学籍管理</p>
						                    </div>
						                </a>
						        <#elseif ml.mhMenuCode=="WELCOME">        
						                <a href="http://192.168.190.14:9083/welcome/main.do" target="_blank">
						                    <div class="rectangle-box backcolor6"><!--单点 新加的-->
						                        <div class="teacher-icon icon19"></div>
						                        <p class="txt">迎新系统</p>
						                    </div>
						                </a>
						        <#elseif ml.mhMenuCode=="WEIKE">         
						               <a href="${rc.contextPath}/Portal/opt-query/gotoHnjdxy.do" target="_blank">
						                    <div class="rectangle-box backcolor7-stu">
						                        <div class="teacher-icon icon17"></div>
						                        <p class="txt">双元微课</p>
						                    </div>
						                </a>       
		                       </#if>
		                    </div>
                      </#if>
                   </#list>

                   </#if> 

                   
                   
                </div>
                <div class="row teacher-box">
                	<!--QQ邮箱-->
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="https://mail.qq.com/cgi-bin/loginpage" target="_blank" title="QQ邮箱">
                            <div class="square-box backcolor13">
                                <div class="interact-icon icon10"></div>
                            </div>
                        </a>
                    </div>
                    <!--126邮箱-->
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="http://mail.126.com/" target="_blank" title="126邮箱">
                            <div class="square-box backcolor10">
                                <div class="interact-icon icon20"></div>
                            </div>
                        </a>
                    </div>
                    <!--163邮箱-->
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="http://mail.163.com/" target="_blank" title="163邮箱">
                            <div class="square-box backcolor12">
                                <div class="interact-icon icon21"></div>
                            </div>
                        </a>
                    </div>
                    <!--新浪邮箱-->
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="http://mail.sina.com.cn/" target="_blank" title="新浪邮箱">
                            <div class="square-box backcolor11">
                                <div class="interact-icon icon22"></div>
                            </div>
                        </a>
                    </div>
                    <!--微信-->
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="https://wx.qq.com" target="_blank">
                            <div class="square-box backcolor10">
                                <div class="interact-icon icon11"></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="http://oa.hnjdxy.cn:8081/jsoa/login.jsp" target="_blank">
                            <div class="square-box backcolor15">
                                <div class="interact-icon icon12"></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-2 col-lg-2 teacher-list">
                        <a href="http://tieba.baidu.com/f?ie=utf-8&kw=%E6%9C%BA%E7%94%B5%E4%BA%BA" target="_blank">
                            <div class="square-box backcolor16">
                                <div class="interact-icon icon13"></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <h2>我的</h2>
                <!--schedule 校历-->
                <!-- <div class="schedule" id="calendar"></div>-->
                <!--
                <div class="schedule">
					<ul class="schedule-list clearfix">
						<li><img src="${rc.contextPath}/css/images/calendar/01.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/02.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/03.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/04.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/05.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/06.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/07.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/08.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/09.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/10.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/11.png" /></li>
						<li><img src="${rc.contextPath}/css/images/calendar/12.png" /></li>
					</ul>
					<div class="schedule-btn">
					<a href="javascript:;" class="prev fl">&lt;</a>
					<a href="javascript:;" class="next fr">&gt;</a></div>
				</div>-->
                <!--schedule -->
                <div class="schedule" id="calendar"></div>
                
                <!--interact-->
                <div class="interact mt10 clearfix">
                    <div class="row">
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 teacher-list"><h2 class="f20 tc">教学<br />互动</h2></div>
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 interact-item teacher-list"><div class="interact-icon-r icon14" title="好评"></div><p class="tc" style="color:white;">${(mhInteract.mhFlower)!"0"}朵</p></div>
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 interact-item teacher-list"><div class="interact-icon-r icon15" title="差评"></div><p class="tc" style="color:white;">${(mhInteract.mhEgg)!"0"}个</p></div>
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 interact-item teacher-list"><a href="${rc.contextPath}/menhu/opt-query/queryMessagesList.do"><div class="interact-icon-r icon16" title="评论"><i class="coin">${(messageUnReadCount)!""}</i></div><p class="tc">${(messageCount)!"0"}条</p></a></div>
                    </div>
                </div>
                <!--course-->
                <div class="course mt10 building">
                    <div class="row">
                    	
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 teacher-list">
                        	<h2 class="f20 tc"><i class="icon icon-small"></i><br />今日<br />任课</h2>
                        </div>
                        <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 teacher-list " >
                            <ul class="course-list">
                                <li class="clearfix"><span>08:00<br />09:40</span>逸夫楼302室    计算机系1班</li>
                                <li class="clearfix"><span>10:20<br />12:00</span>逸夫楼302室    计算机系2班</li>
                                <li class="clearfix"><span>14:00<br />13:40</span>逸夫楼302室    计算机系3班</li>
                            </ul>
                            <p class="tr"><a href="javascript:void(0);">任课表&gt;&gt;</a></p>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $(".custom-but").click(function () {
                if ($(".custom").css("display") == "none") {
                    $(".custom").slideDown("100");
                } else {
                    $(".custom").slideUp("100");
                }
            });
            $(".custom li a").click(function () {
                $(this).toggleClass("current");
            });
            $(".close-btn").click(function () {
                $(".custom li a").removeClass("current");
            });
            $(".square-box img").css({
                    "margin-left": - $(".square-box img").outerWidth() / 2,
                    "margin-top": - $(".square-box img").outerHeight() / 2
            });
            $(".square-box .infor").css({
                "margin-left": -$(".square-box .infor").width() / 2,
                "margin-top": -$(".square-box .infor").height() / 2 + 5
            });
            //系统建设中
            $(".building").append('<div class="building-alert"><p><i class="iconfont f30">&#xe610;</i><br />正在建设中...</p></div>');
            $(".building").parent().removeAttr("href");
            $(".building").hover(function () {
                $(this).find("div.building-alert").fadeIn();
                if ($(this).attr("id") == "rectangleBox") {
                    $(this).find("div.building-alert").css("padding-top", "12%");
                }
            }, function () {
                $(this).find("div.building-alert").fadeOut();
            });
            //控制校历
            var normalWidth = $(".schedule").width();
            var normalHeight = $(".schedule li").height();
            $(".schedule-list, .schedule-list li").width(normalWidth);
            $(".schedule").height(normalHeight);
            $(window).resize(function () {
                var contentWidth = $(".schedule").width();
                var normalHeight = $(".schedule li").height();
               
                $(".schedule-list, .schedule-list li").width(contentWidth);
                $(".schedule").height(normalHeight);
            });
            var month=new Date().getMonth();//默认显示当前月
            jQuery(".schedule").slide({ mainCell: ".schedule-list", effect: "fold", vis: 1, interTime: 3500, delayTime: 500, autoPlay: false ,defaultIndex:month,
                 startFun: function (i, c) {
                    if (i == 8) {//9月的时候不能向前翻页
                    	//alert(i);
                        jQuery(".schedule a.prev").hide();
                    }
                    else if(i == 7	) {//8月的时候不能向后翻页
                        jQuery(".schedule a.next").hide();
                    }else{
                    	jQuery(".schedule a.prev").show();
                    	jQuery(".schedule a.next").show();
                    }
                }});
                function MM_preloadImages() { //v3.0 JF 预加载图片
				    var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
				    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
				    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
				} 
				$(window).load(function() {//配合 预加载图片使用
		            MM_preloadImages('${rc.contextPath}/css/images/calendar/01.png','${rc.contextPath}/css/images/calendar/02.png','${rc.contextPath}/css/images/calendar/03.png','${rc.contextPath}/css/images/calendar/04.png','${rc.contextPath}/css/images/calendar/05.png','${rc.contextPath}/css/images/calendar/06.png','${rc.contextPath}/css/images/calendar/07.png','${rc.contextPath}/css/images/calendar/08.png','${rc.contextPath}/css/images/calendar/09.png','${rc.contextPath}/css/images/calendar/10.png','${rc.contextPath}/css/images/calendar/11.png','${rc.contextPath}/css/images/calendar/12.png');
		        });       
        });
             
    </script>
    <script>
        $(document).ready(function () {
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,',
                    center: 'title',
                    right: 'today next'
                },
                defaultDate: new Date(),
                businessHours: true, // display business hours
                editable: true,
                firstDay: 1,
                weekMode: 'fixed',
                contentHeight: 317,
                weekends: true,
                buttonText: {
                    today:"今天",
                },
                titleFormat:{
                    month: 'YYYY年 MMMM', 
                },
                events: [

                ]
            });
        });

    </script>
    <script type="text/javascript">
        function showLocale(objD) {
            var str, colorhead, colorfoot;
            var yy = objD.getYear();
            if (yy < 1900) yy = yy + 1900;
            var MM = objD.getMonth() + 1;
            if (MM < 10) MM = '0' + MM;
            var dd = objD.getDate();
            if (dd < 10) dd = '0' + dd;
            var ww = objD.getDay();
            if (ww == 0) colorhead = "<font color=\"#ffffff\">";
            if (ww > 0 && ww < 6) colorhead = "<font color=\"#ffffff\">";
            if (ww == 6) colorhead = "<font color=\"#ffffff\">";
            if (ww == 0) ww = "星期日";
            if (ww == 1) ww = "星期一";
            if (ww == 2) ww = "星期二";
            if (ww == 3) ww = "星期三";
            if (ww == 4) ww = "星期四";
            if (ww == 5) ww = "星期五";
            if (ww == 6) ww = "星期六";
            colorfoot = "</font>"
            str = colorhead + yy + "年" + MM + "月" + dd + "日" + "  " + ww + colorfoot;
            return (str);
        }
        function tick() {
            var today;
            today = new Date();
            document.getElementById("localtime").innerHTML = showLocale(today);
            window.setTimeout("tick()", 1000);
        }
        tick();
        
        function  clearMenu(){
             $("li[class=current]").removeClass("current");
        }
        
        function  saveMneu(){
            var obj=$("ul li a.current");
            var str="";
            $.each(obj,function(index,item){
                 str=str+$(item).attr("name")+",";	      
			});
			
			$("#myconfig").hide();
			$.ajax({ 
				type:"post",
				url:"${rc.contextPath}/menhu/opt-save/saveMenusConfig.do",
				data:{"content":str},
				dataType:"text",
				success:function(msg){
					window.location.href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do";				     
				} 
			}); 
        }
        
       function showOrhide(){
           
            if($("#myconfig").is(":visible")){ 
                $("#myconfig").show();
			} else{
			    $("#myconfig").hide();
			   
			}
       }  
    </script>
	<script>
		jQuery.validator.addMethod("uwsUnEqualTo", function(value, element, param) {
			var target = $(param);
			//if (this.settings.onfocusout) {
			//	target.unbind(".validate-equalTo").bind("blur.validate-equalTo", function() {
			//		$(element).valid();
			//	});
			//}
			return value != target.val();
		}, "新密码不能与旧密码一致");  
		jQuery.validator.addMethod("uwsEqualTo", function(value, element, param) {
			var target = $(param);
			return value == target.val();
		}, "新密码不能与旧密码一致");  	
		var form_validation_changepassword = $('.form_validation_changepassword').validate({
			onkeyup: false,
			errorClass: 'error',
			validClass: 'valid',
			focusCleanup:true,
			rules:{
					oldpassword:{required:true,rangelength:[8,32]},
					newpassword:{required:true,rangelength:[8,32],uwsUnEqualTo:'#old_password'},
					verifypassword:{required:true,uwsEqualTo:'#new_password',rangelength:[8,32]}
				},
			highlight: function(element) {
				$(element).closest('div').addClass("f_error");
			},
			unhighlight: function(element) {
				$(element).closest('div').removeClass("f_error");
			},
            errorPlacement: function(error, element) {
                $(element).closest('div').append(error);
            }
        });
	    /*提交之前进行校验*/    
		function changePasswordSubmit(){
			var checkResult = form_validation_changepassword.form();
	        if(checkResult) submitPassword();
		}
		/*提交修改密码信息*/
		function submitPassword(){
			var oldp = $("#old_password").val();
			var newp = $("#new_password").val();
			var verifyp = $("#verify_password").val();
			$.post(
				"${rc.contextPath}/user/user/changePassword.do",
				{
					oldpassword:oldp,
					newpassword:newp,
					verifypassword:verifyp
				},
				function(data){
				    comp.hideModal('changepasswordbox');
					if(data=='success'  || data.length > 100 ){
						
						$.ajax({ 
							type:"post",
							url:"${rc.contextPath}/menhu/opt-upt/updateUserPassword.do",
							dataType:"text",
							success:function(msg){
							   
								if(msg=="success"){
								    
								    $.sticky("密码修改成功！", {autoclose : 5000, position: "top-right", type: "st-info" });
								}else if(msg=="error"){
								    
								    $.sticky("密码修改失败！", {autoclose : 5000, position: "top-right", type: "st-error" });
								}
							} 
						});
						
						
						
					}else if(data=='password_null'){
						$.sticky("密码不能为空！", {autoclose : 5000, position: "top-right", type: "st-error" });
					}else if(data=='new_verify_uequal'){
						$.sticky("新密码与确认密码不一致！", {autoclose : 5000, position: "top-right", type: "st-error" });
					}else if(data=='password_error'){
						$.sticky("用户密码不正确！", {autoclose : 5000, position: "top-right", type: "st-error" });
						$("#old_password").val("");
						document.getElementById("old_password").focus();
					}else if(data=='update_error'){
						$.sticky("修改用户密码失败！", {autoclose : 5000, position: "top-right", type: "st-error" });
					}
				},
				"text"
			);
		}	
		/*点击修改密码进行弹出框*/
    	function changePassword(){
	    	$("#userProfileDiv").load("${rc.contextPath}/user/user/nsm/changePassword.do");
			comp.showModal('changepasswordbox');
	 	}
	 	function showProfile(){/*旧方法 功能略*/
	 		$.ajax({
				url:"${rc.contextPath}/user/user/nsm/getUserProfileUUID.do",
				async:false,
				cache: false,
				type: "POST",
				data:{},
				success: function(msg){
			    	$("#userProfileDiv").load("${rc.contextPath}/user/user/nsm/loadUserProfile.do?" + msg,function(){
    				});
    				comp.showModal("userProfileDiv");
			   }
			});
    		
	 	}
	</script>    
</body>
</html>
