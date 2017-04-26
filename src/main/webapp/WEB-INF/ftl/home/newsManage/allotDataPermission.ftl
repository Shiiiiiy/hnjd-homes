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
	 <script type="text/javascript" src="${rc.contextPath}/js/jquery.pagination.js"></script>
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
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i>${(login_userName)!""}<i class="caret"></i></a>
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
            <li class="active">数据授权</li>
        </ol>
        <div class="content-form clearfix">
		 
            <form class="form-inline search_list" role="form">
                <div class="row border-bot" id="mytable" style="padding-bottom:0;">
                    
					<div class="table-responsive mt20" style="width:80%;margin-left:20px;">
                        <h3>选择学院</h3>
                        <table class="table table-bordered table-striped table-hover mt20">
                            <thead>
                                <tr>
                                    <th width="10%"><input type="checkbox" id="allUser"  onclick="checkAll()">&nbsp;&nbsp;全选</th>
                                    <th width="45%">院系名称</th>
                                    <th width="45%">院系编码</th>
                                </tr>
                            </thead>
                            <tbody id="hiddentable" >
                            <#if collegeList??>
								<#list collegeList as res>
								   <#if res??>
	                                <tr>
	                                    <td><input type="checkbox" name="users" class="${(res.id)!''}" <#if res.path?? && res.path=='ok'>checked</#if>  ></td>
	                                    <td>${(res.name)!""}</td>
	                                    <td>${(res.code)!""}</td>
	                                </tr>
                                  </#if> 
		                        </#list>      
		                     </#if>   
                            </tbody>
                           
                        </table>
						
					</div>
                </div>
                <div class="form-group fbt" style="padding-bottom:0;"><button type="button" class="btn btn-primary btn-md"  onclick="subUserList()">确定</button>&nbsp;<button type="button"  onclick="backToIndex()" class="btn btn-primary btn-md">返回</button></div>
            </form>
        </div>
    </div>
    <div class="backtop news-icon" style="display:none;"></div>
   <input type="hidden" id="roleId" value="${(roleId)!''}">
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
               var str="";
               
	           $("input[name='users']").each(function(){
	                   if($(this).is(':checked')==true){
					       str=str+$(this).attr("class")+",";
					   }   
			   });
			  
              window.location.href="${rc.contextPath}/menhu/opt-save/savePermissions.do?content="+str+"&roleId="+$("#roleId").val()+"&flag="+"college";
              
        }
        
        function checkAll(){
            var all = document.getElementById("allUser");
	        var ch = document.getElementsByName("users");
	        for(var i=0;i<ch.length;i++) {
	            ch[i].checked = all.checked;
	        }
        }
        
        function zhiding(){
            $("#clg1").attr("checked",true);
            $("#clg2").attr("checked",false);
            $("#mytable").show();
        }
        
        function moren(){
            $("#clg1").attr("checked",false);
            $("#clg2").attr("checked",true);
            $("#mytable").hide();
        }
        
        
        
        
    </script>
</body>
</html>
