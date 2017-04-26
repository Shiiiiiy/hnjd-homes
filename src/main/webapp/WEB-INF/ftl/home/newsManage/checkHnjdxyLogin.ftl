<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>验证</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="description" content="This is my page">
<!--引入jquery库-->
<script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
        // 得到session里的用户登录标识
		var userID = "${the_login_account!''}";//学号 工号
		//alert(userID);
		if(""!=userID){
			jump();
		}else{
			$("#dalog").text("帐号为空");
		};
		function jump(){
			var xhrurl = "http://xxkj.hnjdxy.cn/dockingLogin.do?action=checkUser2";
			$.ajax({
		        type : "get",
		        async : false,
		        url :xhrurl,
		        cache : false,
		        dataType : "jsonp",
		        data : {userID : userID},
		        jsonp: "callbackparam",
		        jsonpCallback:"jsonpCallback",
		        success : function(json){
		            if("1"==json.Result && userID==json.userID){
		            	$("#formId").attr("action", json.callbackurl);
		            	$("#tp_token").val(json.tp_token);
		            	$("#userID").val(json.userID);//对方的帐号
			            $("#formId").submit();
		            }else{
			            $("#dalog").text(json.msg);
			            setTimeout("autoJump()",3000);
		            }
		        },
		        error:function(e){
		            $("#dalog").text(json.msg);
		            setTimeout("autoJump()",3000);
		        },
		    });
		};
    });
    function autoJump(){
    	location="http://xxkj.hnjdxy.cn";
    }
</script>
</head>
<body>
	<h3 id= "dalog" align="center">正在努力验证···</h3>
	<form action="" method="post" id="formId">
		<input type="hidden" name="tp_token" id="tp_token"/>
		<input type="hidden" name="userID" id="userID"/>
	</form>
</body>
</html>