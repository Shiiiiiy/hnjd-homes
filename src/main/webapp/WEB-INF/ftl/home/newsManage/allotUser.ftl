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
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i> ${(login_userName)!""} <i class="caret"></i></a>
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
            <li class="active">选择用户</li>
        </ol>
        <div class="content-form clearfix">
            <form class="form-inline search_list" role="form">
                <div class="row border-bot" style="padding-bottom:0;">
                    <div class="table-responsive mt20" style="width:90%;margin-left:20px;">
						<h3>选择用户</h3><br/>姓名&nbsp;<input type="text" id="search" value="${(name)!''}"  style="width:150px;height:35px;"/>&nbsp;<button type="button"  onclick="queryUsers()" class="btn btn-primary btn-md">查询</button>
						<table class="table table-bordered table-striped table-hover mt20" >
							<thead>
								<tr>
									<th width="8%"><input type="checkbox" onclick="checkAll()" id="allUser">&nbsp;&nbsp;全选</th>
									<th width="15%">姓名</th>
									<th width="10%">性别</th>
									<th width="15%">证件类型</th>
									<th width="20%">证件号码</th>
									
								</tr>
							</thead>
							<tbody id="hiddentable" >
							<#if page??>
								<#list page.result as res>
								   <#if res??>
	                                <tr>
	                                    <td><input type="checkbox" name="users" onclick="selectUser(this)" class="${(res.id)!''}" <#if res.address?? && res.address=='ok'>checked</#if>  ></td>
	                                    <td>${(res.name)!""}</td>
	                                    <td>${(res.genderDic.name)!""}</td>
	                                    <td>${(res.certTypeDic.name)!""}</td>
	                                    <td>${(res.certNum)!""}</td>
	                                </tr>
                                  </#if> 
		                        </#list>      
		                     </#if>   
							</tbody>
							
						</table>
						<tbody>
								<tr>
									<td colspan="8" style="background:#f9f9f9;">
										<div class="clearfix">
											<div class="fl">共有  ${(totalCount)!"0"} 条,每页显示 10 条</div>
											<div id="Pagination" class="fr">&nbsp;<a href="javascript:void(0);" onclick="changePage('up')" >上一页</a><span id="pageNo" style="display:inline-block;padding:0 10px;">${(pageNo)!"1"}</span><a href="javascript:void(0);" onclick="changePage('down')">下一页</a></div>
										</div>
									</td>
								</tr>
						</tbody>
						<h3>已选择用户</h3>
						<div style="margin-top:10px;margin-bottom:10px;">
	                            <textarea cols="20" id="nameList" rows="6" name="nameList"  style="width:50%;" readonly><#if selectedList??><#list selectedList as sl>${(sl.mhUserid.name)!""},</#list></#if></textarea>
								<br><font size="1" color="grey" style="vertical-align:bottom; padding-bottom:10px"></font>
	                    </div>
					</div>
					
                </div>
                <div class="form-group fbt" style="padding-bottom:0;"><button type="button"  onclick="subUserList()" class="btn btn-primary btn-md">确定</button>&nbsp;<button type="button"  onclick="backToIndex()" class="btn btn-primary btn-md">返回</button></div>
            </form>
        </div>
        
    </div>
    <input type="hidden" id="idList" name="idList"   value="<#if selectedList??><#list selectedList as sl>${(sl.mhUserid.id)!""},</#list></#if>" />
    
    <input type="hidden" id="roleId" value="${(roleId)!''}">
    <script type="text/javascript">
        
        function selectUser(obj){
            var usId=$(obj).attr("class");
            var oldIdList=$("#idList").val();
            var nameList=$("#nameList").val();
            
            if($(obj).is(':checked')){
                
                if(oldIdList.indexOf(usId)>-1){
                   
                }else{
                    oldIdList=oldIdList+usId+",";
                    $("#idList").val(oldIdList);
                    nameList=nameList+$(obj).parent().next().text()+",";
                    $("#nameList").val(nameList);
                }
                
            }else{
                if(oldIdList.indexOf(usId)>-1){
                   oldIdList=oldIdList.replace(usId+",",'');
                   $("#idList").val(oldIdList);
                   nameList=nameList.replace($(obj).parent().next().text()+",",'');
                   $("#nameList").val(nameList);
                }else{
                    
                }
            }
            
            
        }
        
        function changePage(str){
             if(str=="up"){
                 var pageNo=parseInt($("#pageNo").text());
                 if(pageNo==1){
                     return;
                 }else{
                     getMoreUsers(str);
                 }
             }else if(str=="down"){
                 getMoreUsers(str);
             }
        }
        
        
        function queryUsers(){
             var name= $("#search").val();
             var name=name.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'');
             window.location.href="${rc.contextPath}/menhu/opt-query/queryMhUserList.do?name="+name+"&mhRoleId="+$("#roleId").val();
        }
        
     
        function getMoreUsers(str) {
            
                   var name= $("#search").val();
                   var name=name.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'');
	               $.ajax({ 
							type:"post",
							url:"${rc.contextPath}/menhu/opt-query/queryMhUserListByAjax.do",
							data:{"roleId":$("#roleId").val(),"pageNo": $("#pageNo").text(),"name":name,"sta":str},
							dataType:"json",
							success:function(data){
							     
							     $("#pageNo").text(data.pageNo);
							     if(data.result=="no"){
							     
							     }else{
							              var strrs="";
									      $.each(data.result, function (n, value) {  
									           var st="";
									           if(value.address=="ok"){
									               st="checked";
									           }
								               strrs=strrs+"<tr><td><input type='checkbox' onclick='selectUser(this)' name='users' "+st+" class='"+value.id+"'></td><td>"+value.name+"</td><td>"+value.gender+"</td><td>"+value.certType+"</td><td>"+value.certNum+"</td></tr>";
								               
								          });
								          
								          $("#allUser").attr("checked",false);  
									      $("#hiddentable").html(strrs);
							     }  
						    } 
			        });
        }
            
            
        function checkAll(){
           
            var all = document.getElementById("allUser");
	        var ch = document.getElementsByName("users");
	        for(var i=0;i<ch.length;i++) {
	            ch[i].checked = all.checked;
	        }
	        
	        var objs=$("input[name='users']");
	        
	        $(objs).each(function(){
				  selectUser(this);
		    });
			
        }
        
        
        function backToIndex(){
              window.location.href="${rc.contextPath}/menhu/opt-query/queryRoleList.do";
        }
        
        
        function subUserList(){
              var str=$("#idList").val();
              
              window.location.href="${rc.contextPath}/menhu/opt-save/savePermissions.do?content="+str+"&roleId="+$("#roleId").val()+"&flag="+"user";
        }
        
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
    </script>
</body>
</html>
