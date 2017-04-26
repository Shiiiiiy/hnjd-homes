
		<div class="modal-header">
			<button class="close" data-dismiss="modal">×</button>
			<h3>个人信息</h3>
		</div>
		<div class="modal-body">
			<form  id="userProfileForm" action="${rc.contextPath}/user/user/submitUserProfile.do" method="post">
				<div class="row-fluid">
					<div class="span2">人员名称</div>
					<div class="span10"><#if userProfile??> ${userProfile.name!} </#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">性别</div>
					<div class="span10"><#if userProfile??><#if userProfile.genderDic??> ${(userProfile.genderDic.name)!} </#if></#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">用户类型</div>
					<div class="span10"><#if userProfile??><#if userProfile.userType??> ${(userProfile.userType.name)!} </#if></#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">证件类型</div>
					<div class="span10"><#if userProfile??><#if userProfile.certTypeDic?? > ${(userProfile.certTypeDic.name)!}</#if></#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">证件号码</div>
					<div class="span10"><#if userProfile??>${userProfile.certNum!} </#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">出生日期</div>
					<div class="span10"><#if userProfile??>${userProfile.birthday!} </#if></div>
				</div>
				<div class="row-fluid">
					<div class="span2">手机号码</div>
					<div class="span10"><input type="text" name="phone" id="phone" value="<#if userProfile??>${userProfile.phone!}</#if>"></div>
				</div>
				<div class="row-fluid">
					<div class="span2">固定电话</div>
					<div class="span10"><input type="text" name="tel" id="tel" value="<#if userProfile??>${userProfile.tel!}</#if>"></div>
				</div>
				<div class="row-fluid">
					<div class="span2">电子邮件</div>
					<div class="span10"><input type="text" name="email" id="email" value="<#if userProfile??>${userProfile.email!}</#if>"></div>
				</div>
				<div class="row-fluid">
					<div class="span2">家庭地址</div>
					<div class="span10"><input type="text" name="address" id="address" value="<#if userProfile??>${(userProfile.address!"")?html}</#if>"></div>
				</div>
				<div class="row-fluid">
					<div class="span2">邮编</div>
					<div class="span10"><input type="text" name="postcode" id="postcode" value="<#if userProfile??>${userProfile.postcode!}</#if>"></div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">取消</a>
			<a href="#" class="btn btn-info" onclick="submitUserProfileForm()">确定</a>
		</div>
<script src="${rc.contextPath}/js/jquery.form.js"></script>
<script>
	
	$("document").ready(function(){
		var options = { 
			beforeSubmit: showRequest,
        	success:       showResponse
    	}; 
		$('#userProfileForm').ajaxForm(options); 
		comp.validate.addRule("telCheck", function(value,element) {
			if(value!=""){
				var patrn=/^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/; 
				return patrn.exec(value);
			}else{
				return true;
			}
		}, "请输入合法的座机号码");
		$('#userProfileForm').compValidate({
			onkeyup: false,
			onfocusout: function(element) {if ($(element).val()) $(element).valid(); },
			debug:false,
			errorClass: 'error',
			validClass: 'valid',
			focusCleanup:true,
			focusInvalid:false,
			rules: {
				phone: { 
					minlength:11,
					maxlength:11,
					digits:true
				},
				tel:{
					maxlength:20,
					telCheck:true
				},
				email:{
					maxlength:50,
					email:true
				},
				address:{
					maxlength:100
				},
				postcode:{
					uwsnumchar:true,
					maxlength:10
				}
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
	});
	function submitUserProfileForm() {
		$('#userProfileForm').submit();
	}
	function showRequest() {    
    	var isSuccess=$("#userProfileForm").compValidate().form(); //.form(); 返回是否验证成功 
       	return isSuccess;
    }
	function showResponse(responseText, statusText)  {
		comp.hideModal("userProfileDiv"); 
	    $.sticky(responseText, {autoclose : 5000, position: "top-right", type: "st-info" });
	} 
</script>