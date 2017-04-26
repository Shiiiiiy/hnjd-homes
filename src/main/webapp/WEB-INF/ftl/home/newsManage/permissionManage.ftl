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
            <li class="active">角色管理</li>
        </ol>
        <div class="content-form" style="display:none;">
            <form id="permissionForm" class="form-inline search_list" role="form" action="${rc.contextPath}/menhu/opt-query/queryRoleList.do" method="post">
                <div class="row" style="padding-bottom:0;">
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <label for="name" class="name-label">角色名称</label>
                        <input type="text" class="form-control" id="name" name="mhRoleName" value="${(mhRole.mhRoleName)!''}" placeholder="请输入名称">
                    </div>
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <label for="name" class="name-label">角色编码</label>
                        <input type="text" class="form-control" id="address" name="mhRoleCode" value="${(mhRole.mhRoleCode)!''}" placeholder="请输入名称">
                    </div>
                    <div class="form-group col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <label for="name" class="name-label">角色类型</label>
                        <select class="form-control" name="mhRoleType.id">
                            <option selected="selected">--选择--</option>
                            <#if roleTypeList??>
                                  <#list roleTypeList as t>
                                         <#if mhRole?? && mhRole.mhRoleType?? && mhRole.mhRoleType.id?? && t.id==mhRole.mhRoleType.id >
                                               <option value="${t.id}" selected>${t.mhName}</option>
                                         <else>
                                               <option value="${t.id}" >${t.mhName}</option>
                                         </#if>
                                  </#list>
                            </#if>
                        </select>
                    </div>
					
                    <div class="form-group"><button type="button" class="btn btn-primary btn-md ml20" onclick="queryData()">查询</button><button type="button" class="btn btn-primary btn-md ml20"  onclick="clearForm()">清空</button></div>
                </div>
            </form>
        </div>
        <div class="table-responsive mt20">
            <button type="button" class="btn btn-primary btn-md" onclick="javascript:window.location.href='${rc.contextPath}/menhu/opt-add/addOrEditRole.do'">新增+</button>
            <button type="button" class="btn btn-primary btn-md" onclick="javascript:window.location.href='${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do'">返回</button>
            <table class="table table-bordered table-striped table-hover mt20">
                <thead>
                    <tr>
                        <th width="8%">序号</th>
                        <th width="16%">角色名称</th>
                        <th width="18%">角色编码</th>
                        <th width="18%">角色类型</th>
                        <th width="25%">操作</th>
                    </tr>
                </thead>
                <tbody id="hiddentable">
                   <#if roleList??>
						<#list roleList as res>
						   <#if res??>
                   
			                    <tr>
			                        <td>${res_index+1}</td>
			                        <td>${(res.mhRoleName)!""}</td>
			                        <td>${(res.mhRoleCode)!""}</td>
			                        <td>${(res.mhRoleType.mhName)!""}</td>
			                        <td>
			                            <#if res.mhRoleCode?? && res.mhRoleCode!="SYSTEM_ROLE" &&  res.mhRoleCode!="DEFAULT_ROLE"><a title="编辑" href="${rc.contextPath}/menhu/opt-add/addOrEditRole.do?mhRoleId=${(res.id)!''}"><i class="iconfont f20 mr20">&#xe607;</i></a>
										<a title="删除" href="javascript:void(0);"  class="del-btn"    name="${(res.id)!''}" ><i class="iconfont f20 mr20">&#xe606;</i></a></#if>
										<a title="选择用户"  href="${rc.contextPath}/menhu/opt-query/queryMhUserList.do?mhRoleId=${(res.id)!''}"><i class="iconfont f20 mr20">&#xe60b;</i></a>
										<a title="选择菜单" href="${rc.contextPath}/menhu/opt-query/queryMhMenuList.do?mhRoleId=${(res.id)!''}"><i class="iconfont f20 mr20">&#xe60e;</i></a>
										<a title="选择学院" href="${rc.contextPath}/menhu/opt-query/queryMhcollegesList.do?mhRoleId=${(res.id)!''}"><i class="iconfont f20 mr20">&#xe60d;</i></a>
									</td>
			                    </tr>
			                    
                             </#if>
                          </#list>
                       </#if>  
                   
                </tbody>
               
            </table>
        </div>
    </div>
    
    <!--弹窗-->
    <div class="popup-back" style="display:none;"></div>
    <div class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><b>提示</b></h4>
        <p class="main f16">确认删除吗？</p>
        <p class="tr"><button type="button" class="btn-s cancel-btn">取消</button><button type="button" id="shure" class="btn-s confirm-btn" name="" onclick="delMhRole(this)">确定</button></p>
    </div>
    
    <div class="backtop news-icon" style="display:none;"></div>
   
   <script>
        $(function () {
            $("a.del-btn").click(function () {
                $("#shure").attr("name",$(this).attr("name"));
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
        
        function clearForm(){
		     $(':input','#permissionForm')  
			 .not(':button, :submit, :reset, :hidden')  
			 .val('')  
			 .removeAttr('checked')  
			 .removeAttr('selected'); 
		}
        
        function queryData(){
             $("#permissionForm").submit();
        }
        
        function delMhRole(obj){
              var mhRoleId=$(obj).attr("name");
              $("#shure").attr("name","");
              window.location.href="${rc.contextPath}/menhu/opt-del/delMhRole.do?mhRoleId="+mhRoleId;
          
        }
        
        
    </script>
</body>
</html>
