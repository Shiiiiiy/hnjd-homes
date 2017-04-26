<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/teacher.css">
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/bootstrap.min.js"></script>
    <!--[if lte IE 9]>
    <script src="${rc.contextPath}/js/respond.min.js"></script>
    <script src="${rc.contextPath}/js/html5shiv.js"></script>
    <![endif]-->
    <title>角色管理</title>
</head>
<body>
    <!--header-->
    <div class="header w clearfix">
        <div class="container">
            <div class="pull-left"><img src="${rc.contextPath}/css/images/logo.png" alt="" /></div>
            <div class="pull-right">
                <div id="localtime" class="f14 ml20 white fl hidden-xs"></div>
                <div class="fl dropdown ml30">
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i>  ${(login_userName)!""}<i class="caret"></i></a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="<#if login_userType?? && login_userType=='STUDENT'>${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do<#elseif  login_userType?? && login_userType=='TEACHER' && login_isSuperUser?? && login_isSuperUser='1'>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do?superuser=true<#else>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do</#if>">主页</a>
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
        <ol class="breadcrumb mt20">
            <li><a href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do">门户首页</a></li>
            <li><a href="${rc.contextPath}/menhu/opt-query/queryRoleList.do">角色管理</a></li>
            <li class="active"><#if mhRole?? && mhRole.id??>修改角色<#else>新增角色</#if></li>
        </ol>
        <div class="content-form clearfix">
            <form class="form-inline search_list" role="form" id="addOrEditRole" action="${rc.contextPath}/menhu/opt-save/saveRole.do" method="post">
                <div class="row border-bot" style="padding-bottom:0;">
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-4">
                        <label for="name" class="name-label">角色名称<span style="color:red;">*</span></label>
                        <input type="hidden" value="${(mhRole.id)!''}" id="id" name="id" />
                        <input type="text" class="form-control" value="${(mhRole.mhRoleName)!''}" name="mhRoleName" id="name" placeholder="请输入名称">
                    </div>
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-4">
                        <label for="name" class="name-label">角色编码<span style="color:red;">*</span></label>
                        <input type="text" class="form-control" value="${(mhRole.mhRoleCode)!''}" name="mhRoleCode" id="address" placeholder="请输入编码">
                    </div>
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-4">
                        <label for="name" class="name-label">角色类型<span style="color:red;">*</span></label>
                        <select class="form-control" name="mhRoleType.id">
                            <#if roleTypeList??>
                                  <#list roleTypeList as t>
                                         <#if mhRole?? && mhRole.mhRoleType?? && mhRole.mhRoleType.id?? && t.id==mhRole.mhRoleType.id >
                                               <option value="${t.id}" selected>${t.mhName}</option>
                                         <#else>
                                               <option value="${t.id}" >${t.mhName}</option>
                                         </#if>
                                  </#list>
                            </#if>
                        </select>
                    </div>
                   
                </div>
                <div class="form-group fbt" style="padding-bottom:0;"><button type="button" class="btn btn-primary btn-md"  onclick="subUserList()">确定</button>&nbsp;<button type="button"  onclick="backToIndex()" class="btn btn-primary btn-md">返回</button></div>
            </form>
        </div>
    </div>
    <div class="backtop news-icon" style="display:none;"></div>
    
    
     <!--弹窗-->
	<div class="popup-back" style="display:none;"></div>
    <div class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><B>提示</B></h4>
        <p class="main f16" id="mains">评论与回复的内容不能超过200字符!</p>
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
    
    <script type="text/javascript">
        $(function () {
            $('.backtop').click(function () {
                $('body,html').animate({ scrollTop: 0 }, 500);
            });
            $(window).scroll(function () {
                var height = $(window).scrollTop();
                if (height > 200) {
                    $('.backtop').fadeIn();
                } else {
                    $('.backtop').fadeOut();
                };
            });
        });
        
        function backToIndex(){
              window.location.href="${rc.contextPath}/menhu/opt-query/queryRoleList.do";
        }
        
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
        
        function subUserList(){
            var name= $("#name").val();
            var code=$("#address").val();
            var roleId=$("#id").val();
             
            name=name.replace(/(^\s*)|(\s*$)/g,'');
            code=code.replace(/(^\s*)|(\s*$)/g,'');
            var name=name.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'');
            var code=code.replace(/[^\a-\z\A-\Z0-9]/g,'');
            
            document.getElementById("name").value=name;
	        document.getElementById("address").value=code;
	        
	        if(name.length>20){
                     $("#mains").text("角色名称不能超过20字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(name==null || name==""){
                     $("#mains").text("角色名称不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(code.length>20){
                     $("#mains").text("角色编码不能超过20字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(code==null || code==""){
                     $("#mains").text("角色编码不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }
            
	       $.ajax({ 
						type:"post",
						url:"${rc.contextPath}/menhu/opt-query/checkMhRoleCode.do",
						data:{"codes":code,"roleName":name,"roleId":roleId},
						dataType:"json",
						success:function(data){

						      if(data.codeStat=="no"){
						          $("#mains").text("角色编码不能重复!");
			                      $("div.popup-back, div.popup-content").fadeIn();
			                      
						      }else if(data.nameStat=="no"){
						          $("#mains").text("角色名称不能重复!");
			                      $("div.popup-back, div.popup-content").fadeIn();
						      }else{
						          $("#addOrEditRole").submit();
						      }
					    }
		     });
	      
            
        }
        
    </script>
</body>
</html>
