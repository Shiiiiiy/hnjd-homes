<form  id="changePasswordForm" class="form_validation_changepassword" action="" method="post">
	<div class="row-fluid">
		<div class="span2">旧密码<span class="f_req" style="color:red;">*</span></div>
		<div class="span10"><input type="password" name="oldpassword" value="" id="old_password" class="{messages:{required:'旧密码不能为空'}}" style="float:left;"></div>
	</div>
	<div class="row-fluid">
		<div class="span2">新密码<span class="f_req" style="color:red;">*</span></div>
		<div class="span10"><input type="password" name="newpassword" value="" id="new_password" class="{messages:{required:'新密码不能为空'}}" style="float:left;"></div>
	</div>
	<div class="row-fluid">
		<div class="span2">确认密码<span class="f_req" style="color:red;">*</span></div>
		<div class="span10"><input type="password" value="" name="verifypassword" id="verify_password" class="{messages:{uwsEqualTo:'两次输入密码不一致',required:'确认密码不能为空'}}" style="float:left;"></div>
	</div>
</form>