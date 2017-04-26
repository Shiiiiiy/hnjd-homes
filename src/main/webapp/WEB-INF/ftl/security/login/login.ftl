<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/css.css" rel="stylesheet" type="text/css" />
<script src="${rc.contextPath}/js/jquery.min.js"></script>
        <!--[if lt IE 9]>
            <script src="lib/html5shiv/html5.js"></script>
            <script src="lib/flot/excanvas.min.js"></script>
        <![endif]-->

<script src="${rc.contextPath}/js/jquery.cookie.min.js"></script>
<script language="javaScript">
	
	
		function codefocus(){
			clearErrorMessage();
			$("#codeError").html("");
		}
	
		function passwordfocus(){
			clearErrorMessage();
			$("#passwordError").html("");
		}
	
		function usernamefocus(){
			clearErrorMessage();
			$("#usernameError").html("");
		}
	
		function clearErrorMessage(){
			if($("#errorMessageDiv").size()!=0){
				//$("#errorMessageDiv").text("");
				$("#errorMessageDiv").remove();
			}
		}
	
	
		function login(){
			clearErrorMessage();
			var username = $("input[name='username']").val();
			var password = $("input[name='password']").val();
			var authcode = $("input[name='code']").val();
			var charRg = "^[0-9]{4}$";
			var charRe=new RegExp(charRg);
			
			if(username == ''){
				 $("#usernameError").html("用户名不能为空");
				 passwordfocus();
				 codefocus();
				 return false;
			}
			if(password == ''){
				 $("#passwordError").html("密码不能为空");
				 usernamefocus();
				 codefocus();
				 return false;
			}
			if(authcode == ''){
				 $("#codeError").html("验证码不能为空");
				 usernamefocus();
				 passwordfocus();
				 return false;
			}
			if(!charRe.test(authcode)){
				 $("#codeError").html("验证码格式不正确");
				 usernamefocus();
				 passwordfocus();
				 return false;
			}
			//var checkLogin = checkuu && checkp && checkC;
			//将用户名保存到cookie中，有效期为7天
			$.cookie('_login_username_', $.trim($("input[name='username']").val()),{expires:7});
			return true;
		}
		
		$(document).ready(function(){
			var login_username = $.cookie('_login_username_');
			if(login_username){
				$("input[name='username']").val(login_username);
			}
            });
	</script>
</head>
<body>
<div class="wapper">
<div class="header">
<a href="#" class="logo"  style="background:url(${rc.contextPath}/images/${_prefix_}logo.jpg) no-repeat 40px 15px;"></a>
<span>中国职教领域软件产品第一领导品牌</span>
</div>
<div class="main">
<div class="main_cent">
<!--
<div class="main_left">
<ul>
<li>◆ 统一身份认证, 单点登录SSO（Single Sign On）</li>
<li>◆ 统一数据交换,共享公共数据，完整性和一致性</li>
<li>◆ 符合教育资源建设技术规范，开放性和规范性</li>
<li>◆ 整合校园各种应用系统，集成化服务平台</li>
</ul>
</div>
-->
<div class="main_right">
	<form action="${rc.contextPath}/loginauth.do" method="post" id="login_form" onsubmit="return login()">
			<p class="login_top"></p>
			<span style="color:#c62626;margin-left:50px;">
			<span id="usernameError"></span>
			<span id="passwordError"></span>
			<span id="codeError"></span>
			<#if errorMessage??>
			<span id="errorMessageDiv">${errorMessage}</span>
			<#else>
			</#if>
			</span>
			<p><span class="span1">&nbsp;&nbsp;&nbsp;</span>
				<input type="text" id="username" name="username"  class="J_input" onfocus="usernamefocus()"  placeholder="用户名"/>
				</p>
			<p><span class="span2">&nbsp;&nbsp;&nbsp;</span>
			<input name="password" type="password"  id="password" onfocus="passwordfocus()"  placeholder="密码"/>
			</p>
			<div class="yzm"><p class="yzm"><span class="span3">&nbsp;&nbsp;&nbsp;</span>
			<input type="text" id="code" name="code"  class="proving"  onfocus="codefocus()"  placeholder="验证码" />
			
			 </p>
			 <img width="63" height="37" src ="${rc.contextPath}/authcode.do?abc=${coderandom}" id="123" onclick="this.src='${rc.contextPath}/authcode.do?abc='+Math.random()" title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/>
			 </div>
			
			<span><button class="but" type="submit">登 录</button></span>
	</form>
</div>

</div>
</div>		
<div class="footer">
    <div class="footerL">
    <p>Copyright &copy; 2004-2012  UwaySoft 联合永道 All Rights Reserved</p>
    <p>请使用IE8 以上浏览器，分辨率最低支持 1024 x 768</p>
    </div>
    <p class="footerR">400-015-1018</p>
</div>


</div>
</body>
</html>
