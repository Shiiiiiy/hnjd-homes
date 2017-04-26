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
    <title>学生门户</title>
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
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i> ${(StuUser.XM)!"缺省"} <i class="caret"></i></a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                        	<a href="javascript:changePassword()">修改密码</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do">主页</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="${rc.contextPath}/logout.do">退出</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container mb50">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 teacher-list">
                <h2>我的</h2>
                     <!--弹窗-->
				    <div class="popup-back" style="display:none;"></div>
				    <div class="popup-content" style="display:none;">
				        <h4><span class="fr close-x">X</span><B>提示</B></h4>
				        <p class="main f16" id="mains">缺省!</p>
				        <p class="tr"><button type="button"  class="btn-s confirm-btn" >确定</button></p>
				    </div>
				    <script>
				        $(function () {
				            $("a.del-btn").click(function () {
				                $("div.popup-back, div.popup-content").fadeIn();
				            });
				            $(".btn-s, span.close-x").click(function () {
				                $(".popup-back, .popup-content").fadeOut();
				            });
				        });
				    </script>
                <!--application-->
                <div class="row teacher-box">
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <div class="square-box backcolor1-stu">
                            <div class="infor-stu mt30">
                            <div class="slider-box">
                                <div class="slider-btn">
                                <a href="javascript:;" class="fl" onclick="preTea()">&lt;</a>
                                <a href="javascript:;" class="fr" onclick="nextTea()">&gt;</a></div>
                                <ul class="slider-con">
                                    <li><img src="${rc.contextPath}/css/images/user.jpg" alt="teacher" />
                                    <p class="name" id="NowTeaN">${(PingTeaName)!''}老师</p></li>                                   
                                </ul>
                                <input type="hidden" value="${(PingTeaId)!''}" id="NowTeaId" />
                            </div>                          
                            <p class="xx">给你的任课老师课程点个赞吧!</p><br/>   
                            <span class="f12" style="display:none;">已有0人参与</span>
                            </div>
                            <div class="row" style="width:80%; margin:auto;">
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 interact-item teacher-list"><a href="javascript:void(0);" onclick="funny()"><div class="interact-icon-r icon14" title="好评"></div></a></div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 interact-item teacher-list"><a href="javascript:void(0);" onclick="notfunny()"><div class="interact-icon-r icon15" title="差评"></div></a></div>
                                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 interact-item teacher-list"><a href="javascript:void(0);" onclick="shuoshuo()"><div class="interact-icon-r icon16" title="评论"></div></a></div>
								<input type="hidden" value="0" id="haop"/>
								<input type="hidden" value="0" id="chap"/>
								<script>
									function shuoshuo(){//上一名							
										teaid=$("#NowTeaId").val();
										//alert(teaid);
										window.location ="${rc.contextPath}/menhu/opt-query/queryMessagesList.do?teacherId="+teaid;
									}
									function preTea(){//上一名
										var tid=$("#NowTeaId").val();
										$.ajax({
							                url:"${rc.contextPath}/studentPortal/opt-query/getPreTeacher.do",
							                type:"post",
							                data:{"teaNameNow":tid},
							                dataType:"json",    
							                success : function(obj){
							                     // alert(obj.tName);
							                     //alert(obj.tID);
							                    $("#NowTeaId").val(obj.tID);
							                    $("#NowTeaN").html(obj.tName+"老师");
							                }
							            });
									}
									function nextTea(){//下一名
										var tid=$("#NowTeaId").val();
										$.ajax({
							                url:"${rc.contextPath}/studentPortal/opt-query/getNextTeacher.do",
							                type:"post",
							                data:{"teaNameNow":tid},
							                dataType:"json",    
							                success : function(obj){
							                    //alert(obj.tName);
							                    //alert(obj.tID);
							                    $("#NowTeaId").val(obj.tID);
							                    $("#NowTeaN").html(obj.tName+"老师");
							                }
							            });
									}
								    function funny(){//点赞
								        var cishu=$("#haop").val();
								        var tid=$("#NowTeaId").val();
								        if(cishu==0){ //可点赞
								            $.ajax({
								                url:"${rc.contextPath}/menhu/opt-add/updateMhInteract.do",
								                type:"post",
								                data:{"flag":"flower","teacherId":tid},
								                dataType:"text",    
								                success : function(obj){
								                    if( obj.indexOf("ok") > -1 ){
														 $("#mains").text("评价成功!");
									                     $("div.popup-back, div.popup-content").fadeIn();
								                    }else{
								                    	 $("#mains").text("已经评价，不可再评价!");
									                     $("div.popup-back, div.popup-content").fadeIn();
								                    }
								                }
								            });
								        }
								    };
								    function notfunny(){//给差评
								        var cishu1=$("#chap").val();
								        var tid=$("#NowTeaId").val();
								        if(cishu1==0){ //可差评
								            $.ajax({
								                url:"${rc.contextPath}/menhu/opt-add/updateMhInteract.do",
								                type:"post",
								                data:{"flag":"egg","teacherId":tid},
								                dataType:"text", 
								                success : function(obj){
								                    if(obj.indexOf("ok") > -1){
														 $("#mains").text("评价成功!");
									                     $("div.popup-back, div.popup-content").fadeIn();
								                    }else{
								                    	 $("#mains").text("已经评价，不可再评价!");
									                     $("div.popup-back, div.popup-content").fadeIn();
								                    }
								                }
								            });
								        }
								    };
								</script>
                            </div>
                            <p class="txt">教学互动</p>
                        </div>
                    </div>
                    <!---课表查询-->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                    	<a href="http://www.hnjd.edu.cn" target="_blank">
                        <div class="square-box backcolor2-stu building"><!--building--->
                            <div class="box-stu-w">
                                <h3 class="f20">今日共3门课程</h3>
                                <ul class="course-list stu-list">
                                    <li class="clearfix"><span class="se">08:00<br />09:40</span>逸夫楼302室    计算机系1班</li>
                                    <li class="clearfix"><span class="se">10:20<br />12:00</span>逸夫楼302室    计算机系2班</li>
                                    <li class="clearfix"><span class="se">14:00<br />15:40</span>逸夫楼302室    计算机系3班</li>
                                </ul>
                            </div>
                            <p class="txt" style="width:90%">课表查询</p>
                        </div>
                        </a>
                    </div>
                    <!---图书借阅-->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                    	<a href="http://www.hnjd.edu.cn" target="_blank">
                        <div class="square-box backcolor3-stu building"><!--building--->
                            <div class="box-stu-w">
                                <h3 class="f20">共借阅4本书</h3>
                                <ul class="course-list stu-list">
                                    <li class="clearfix">6月2日 - 7月2日 周宏伟自述</li>
                                    <li class="clearfix">6月2日 - 7月2日 中国经济</li>
                                    <li class="clearfix">6月2日 - 7月2日 就业课培训</li>
                                    <li class="clearfix">6月2日 - 7月2日 如何练习演讲</li>
                                </ul>
                            </div>
                            <p class="txt" style="width:90%">图书借阅</p>
                        </div>
                        </a>
                    </div>
                    <!---考勤管理-->
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                    	<a href="http://192.168.190.14:9088/smartRegister/smartregister/editregister/toEditSmartRegisterUI.do" target="_blank">
                        <div class="square-box backcolor4-stu " ><!--building--->
                            <div class="box-stu-w">
                                <h3 class="f20">本月考勤记录</h3>
                                <div class="teacher-icon icon6"></div>
                                <div class="infor">
                                    <p class="infor-con"><i class="circle mr10">未签</i><span class="f30">${notsign!"0"}次</span></p>
                                </div>
                            </div>
                            <p class="txt" style="width:90%">考勤记录</p>
                        </div>
                        </a>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <a href="${rc.contextPath}/studentPortal/opt-query/studentDetailsFrame.do?menuParam=active1" >
                            <div class="rectangle-box backcolor5-stu">
                                <div class="teacher-icon icon5"></div>
                                <div class="txt">
                                <p><span class="price">${haspadfee!"0"} </span>元</p>
                                <p>缴费信息<span class="f12 sma backg1">本学期已缴</span></p></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <a href="${rc.contextPath}/Portal/opt-query/gotoHnjdxy.do" target="_blank">
                            <div class="rectangle-box backcolor7-stu">
                                <div class="teacher-icon icon17"></div>
                                <div class="txt">
                                <p style="font-size:16px;">双元微课</p></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <a href="http://192.168.190.14:9086/uws-stu/stusys/portalpage/main.do" target="_blank">
                            <div class="rectangle-box backcolor3-stu">
                                <div class="teacher-icon icon8"></div>
                                <div class="txt">
                                <p style="font-size:16px;">学生管理</p></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <a href="http://192.168.190.14:9084/edu2/main.do" target="_blank">
                            <div class="rectangle-box backcolor6-stu">
                                <div class="teacher-icon icon18"></div>
                                <div class="txt">
                                <p style="font-size:16px;">学籍管理</p></div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 teacher-list">
                        <a href="http://www.hnjd.edu.cn" target="_blank">
                            <div class="rectangle-box backcolor6-stu building" id="rectangleBox"><!--building--->
                                <div class="teacher-icon icon1"></div>
                                <div class="txt">
                                <p><span class="price">0.0 </span>元</p>
                                <p>一卡通信息<span class="f12 sma backg2">余额</span></p></div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <h2>学校</h2>
                <!--schedule 校历-->
                <div class="schedule" id="calendar"></div>
                <!--<div class="schedule">
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
                
                <!--interact-->
                <div class="picnews mt10 clearfix">
                        <img src="${rc.contextPath}/css/images/xs.png" alt="图片" />
                    <div></div>
                </div>
                <!--news 新闻功能作废-->
                <!--- <div class="course mt10">
                    <ul class="course-list">
                        <#if mhNewslist??> <#list mhNewslist as nsl>
	                        <li><a href="${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId=${(nsl.id)!''}&newStat=A"><span><#if nsl??>${(nsl.createTime)?string("MM-dd")}</#if></span>${((nsl.mhNewsTitle)!"")?html}</a></li>
                        </#list> </#if>
                    </ul>
                    <p class="tr"><a href="${rc.contextPath}/menhu/opt-query/queryNewsList.do">更多&gt;&gt;</a></p>
                </div>-->
            </div>
        </div>
    </div>
    <script>
        $(function () {
            //系统建设中
            $(".building").append('<div class="building-alert"><p><i class="iconfont f30">&#xe610;</i><br />正在建设中...</p></div>');
            $(".building").parent().removeAttr("href");
            $(".building").hover(function () {
                $(this).find("div.building-alert").fadeIn();
                if ($(this).attr("id") == "rectangleBox") {
                    $(this).find("div.building-alert").css("padding-top", "15%");
                }else {
                	$(this).find("div.building-alert").css("padding-top", "40%");
                }
            }, function () {
                $(this).find("div.building-alert").fadeOut();
            });
            //
            $(".square-box .infor").css({
                "margin-left": -$(".square-box .infor").width() / 2,
                "margin-top": -$(".square-box .infor").height() / 2 + 5
            });
            //jQuery(".slider-box").slide({ mainCell: ".slider-con", effect: "leftLoop", vis: 1, interTime: 4500, delayTime: 500, autoPlay: false });
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
					if(data=='success' || data.length > 100  ){						
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
