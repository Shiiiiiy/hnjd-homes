<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/layout.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/tools.js"></script>
    <title>首页</title>
</head>
<body class="easyui-layout" style="overflow:hidden;">
	<!--弹窗-->
	<div class="popup-back" style="display:none;"></div>
	<div class="popup-content" style="display:none;">
	<h4><span class="fr close-x">X</span><B>提示</B></h4>
	<p class="main f16" id="mains">缺省!</p>
	<p class="tr"><button type="button"  class="btn-s confirm-btn" >确定</button></p>
	</div>
	<script>
	function  sysAlert(msg){
	     $("#mains").text(msg);
	     $("div.popup-back, div.popup-content").fadeIn();
	};
	$(function () {
	    $("a.del-btn").click(function () {
	        $("div.popup-back, div.popup-content").fadeIn();
	    });
	    $(".btn-s, span.close-x").click(function () {
	        $(".popup-back, .popup-content").fadeOut();
	    });
	});
	</script>
    <!-- header -->
    <div data-options="region:'north'" style="height:50px">
        <div class="header_uway clearfix">
            <div class="logo fl"><a href="javascript:;" class="but"><i class="iconfont f20 mr10">&#xe600;</i></a><img src="${rc.contextPath}/css/images/logo-top.png" /></div>
            <div class="infor fr ">
            <!--<a href="javascript:void(0);" class="easyui-menubutton skin-btn" data-options="menu:'#mm1'"><i class="iconfont f20 white">&#xe602;</i></a>-->
            <span id="localtime" class="f14 ml20 white"></span><em>|</em>
            <span class="f14"><a href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do" style="color:white">河南机电主页</a></span></div>
            <!--<div id="mm1" class="skin-select" style="width:240px;">
                <ul class="pt10">
                    <li class="skin-default"></li>
                    <li class="skin-green"></li>
                    <li class="skin-purple"></li>
                    <li class="skin-red"></li>
                </ul>
            </div>-->

        </div>
    </div>
    <!-- leftmenu -->
    <div class="layout-left" >
    	
        <div class="user-box">
            <a href="javascript:void(0)" class="easyui-menubutton user-btn" data-options="menu:'#mm2'" style="width:250px; margin-left:-70px;"><img src="${rc.contextPath}/css/images/user.jpg" alt="user" />
            <span class="f14">${(TeaUser.TEACHER_NAME)!""}
            <!--<#list TeaUser.ORG_NAME as nn>
            	${nn},
            </#list> 
            ${TeaUser.isFullPower}-->
            </span><b class="class-infor"></b></a>
            <div id="mm2" class="user-menu" style="width:116px;">
                <a href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do">主页</a>
                <a href="${rc.contextPath}/logout.do" class="border-t">退出</a>
            </div>
        </div>
        <div class="division"></div>
        <div class="nav">
            
            <#if canview??>
            <#list canview as ll>
            	<#if ll=="缴费信息统计">
            	<div class="submenu">
	                <a href="${rc.contextPath}/teacherPortal/opt-query/statistStudentTuition.do" 
	                target="content-box" class="class_a" id="active1"><span class="arrow expand"></span><i class="nav-icon iconmenu1">
	                </i>缴费信息统计</a><ul style="display:none;"></ul>
	            </div>
	            <#elseif ll=="学生信息统计">
	            <div class="submenu">
	                <a href="${rc.contextPath}/teacherPortal/opt-query/statistStudentInfo.do" 
	                target="content-box" class="class_a" id="active2"><span class="arrow"></span><i class="nav-icon iconmenu2">
	                </i>学生信息统计</a><ul style="display:none;"></ul>
            	</div>
                <#elseif ll=="教职工信息统计">
                <div class="submenu">
	                <a href="${rc.contextPath}/teacherPortal/opt-query/statistTeacherInfo.do" 
	                target="content-box" class="class_a" id="active3"><span class="arrow"></span><i class="nav-icon iconmenu3">
	                </i>教职工信息统计</a><ul style="display:none;"></ul>
            	</div>
                <#elseif ll=="一卡通信息">
                <div class="submenu">
	                <a href="javascript:sysAlert('系统建设中...');" target="content-box" class="class_a" id="active4"><span class="arrow"></span><i class="nav-icon iconmenu4">
	                </i>一卡通信息</a><ul style="display:none;"></ul>
                </div>
                <#elseif ll=="教学资源使用情况">
	            <div class="submenu">
	                <a href="http://192.168.190.17:9089/rodrcm" target="_blank" class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu5">
	                </i>教学资源使用情况</a><ul style="display:none;"></ul>
	            </div>
                <#elseif ll=="部门资产">
	            <div class="submenu">
	                <a href="javascript:sysAlert('系统建设中...');" target="content-box" class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu6">
	                </i>部门资产</a><ul style="display:none;"></ul>
	            </div>
                <#elseif ll=="图书借阅">
	            <div class="submenu">
	                <a href="javascript:sysAlert('系统建设中...');" target="content-box" class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu7">
	                </i>图书借阅</a><ul style="display:none;"></ul>
	            </div>
                <#elseif ll=="课表查询">
	            <div class="submenu">
	                <a href="javascript:sysAlert('系统建设中...');" target="content-box" class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu8">
	                </i>课表查询</a><ul style="display:none;"></ul>
	            </div>
                <#elseif ll=="学生考勤信息">
                <div class="submenu">
	                <a href="http://192.168.190.14:9088/smartRegister/smartregister/editregister/toEditSmartRegisterUI.do" target="_blank" class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu9">
	                </i>学生考勤信息</a>
	                <ul style="display:none;"></ul>
            	</div>
                <#else>
                </#if> 
            </#list>    
            </#if>    
            <div class="submenu">
                <a href="javascript:sysAlert('系统建设中...');" target="content-box" class="class_a"><span class="infor-new green" style="display:none">5</span><span class="arrow"></span><i class="nav-icon iconmenu11">
                </i>任课详情</a>
                <ul style="display:none;">
                    <!--<li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>-->
                </ul>
            </div>
            <div class="submenu">
                <a href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do"  class="class_a"><span class="arrow"></span><i class="nav-icon iconmenu12">
                </i>校历</a>
                <ul style="display:none;">
                    <!--<li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>
                    <li><a href="#">二级菜单</a></li>-->
                </ul>
            </div>
            <div class="division mt10"></div>
        </div>
    </div>
    <!-- content -->
    <div data-options="region:'center'" class="layout-content">
        <iframe src="javascript:void(0)" allowtransparency="" width="100%" height="100%" frameborder="0" name="content-box" scrolling="auto" id="theiframeid"></iframe>
    </div>
    <script>
        $(function () {
            //初始化 ifream
        	var menu="${menuParam!'javascript:;'}";
        	var thehref=document.getElementById(""+menu+"").href;
		    $("#theiframeid").attr("src",thehref);
		    $("#"+menu+"").addClass("active");//进来图标变色
            //折叠菜单
            $("a.class_a").click(function () {
                if ($(this).parent().children("ul").css("display") == "none") {
                    $(this).addClass("active");
                    $(this).find("span").addClass("expand");
                    $(this).parent().siblings().children("a.class_a").removeClass("active");
                    $(this).parent().siblings().children("a.class_a").children("span").removeClass("expand");
                    $(this).parent().children("ul").slideDown(100);
                    $(this).parent().siblings().children("ul").slideUp(100);
                } else {
                    $(this).parent().children("ul").slideUp(100);
                    //$(this).removeClass("active");
                    $(this).find("span").removeClass("expand");
                }
            });
            $(".submenu li a").click(function () {
                $(this).addClass("current");
                $(this).parents("div.submenu").siblings().children("ul").children().children().removeClass("current");
                $(this).parents("li").siblings().children().removeClass("current");
            });
        });
    </script>
        <script>
        $(function () {
            var bodyWidth = $(window).width();
            //
            var bodyHeight = $(".layout-content").height();
            $("#theiframeid").height(bodyHeight);
            $(window).resize(function () {
                var bodyHeight= $(".layout-content").height();
                $("#theiframeid").height(bodyHeight);
            });
            //
            $(".layout-content").width(bodyWidth - 250);
            $(window).resize(function () {
                var contentWidth = $(window).width();
                $(".layout-content").width(bodyWidth - 250);
            });
            $(".but").click(function () {
                if ($(".layout-left").css("display") == "none") {
                    $(".layout-left").animate({ "left": "0px" }, 200);
                    $(".layout-content").animate({ "left": "250px" }, 200);
                    $(".layout-left").css("display", "block");
                    var bodyWidth = $(window).width();
                    $(".layout-content").width(bodyWidth - 250);
                    $(window).resize(function () {
                        var contentWidth = $(window).width();
                        $(".layout-content").width(contentWidth - 240);
                    });
                } else {
                    $(".layout-left").animate({ "left": "-250px" }, 200);
                    $(".layout-content").animate({ "left": "0px" }, 200);
                    $(".layout-left").css("display", "none");
                    var bodyWidth = $(window).width();
                    $(".layout-content").width(bodyWidth);
                    $(window).resize(function () {
                        var contentWidth = $(window).width();
                        $(".layout-content").width(contentWidth);
                    });
                }
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
            str = colorhead + yy + "-" + MM + "-" + dd + "  " + ww + colorfoot;
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
</body>
</html>