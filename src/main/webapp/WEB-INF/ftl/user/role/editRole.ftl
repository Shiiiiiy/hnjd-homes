<html>
<title>form elements</title>
<head>
<!--validata-->	
	<script src="${rc.contextPath}/js/jquery.metadata.js"></script>
	<script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
	<script src="${rc.contextPath}/js/myjs_message_cn.js"></script>
<!-- sticky messages -->
	<script src="${rc.contextPath}/lib/sticky/sticky.min.js"></script>
	
	<script src="${rc.contextPath}/js/jquery.form.js"></script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
		<input name="errorText" id="errorText" type="hidden" value="${errorText!""}"/>
		<#if role?? && role.id?? >
			<h3 class="heading">修改角色</h3>
			<form  id="roleForm" class="form_validation_reg" action="${rc.contextPath}/user/role/opt-update/saveRole.do" method="post">
		<#else>
			<h3 class="heading">新增角色</h3>
			<form  id="roleForm" class="form_validation_reg" action="${rc.contextPath}/user/role/opt-add/saveRole.do" method="post"><@token/>
		</#if>
		<input id="id" type="hidden" name="id"  value="${(role.id)!""}">
					
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
							<label >角色名称 <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<input id="name" name="name"  value="${(role.name)!""}" 
								class="{required:true,minlength:1,maxlength:30,namecheck:true,uwsnumcharcn:true,messages:{required:'角色名称不能为空'}}" />
						</div>
					</div>
					<div class="span5">
						<div class="span3">
							<label >角色编码  <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<input id="code" name="code"  value="${(role.code)!""}"
								class="{required:true,minlength:1,maxlength:32,codecheck:true,uwsnumchar:true,messages:{required:'角色编码不能为空'}}" />
						</div>
					</div>
				</div>
			</div>
					
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
								<label >角色类型 <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<select size="1" name="type" aria-controls="dt_gal" class="{required:true,messages:{required:'角色类型不能为空'}}" >
								<option  value="" />请选择..</option>
								<#if role.id?? >
									<#list dicRoleType as dic>
										<#if dic.id==role.roleTypeDic.id >
											<option  value="${dic.id}" selected="selected" />${dic.name}</option>
										<#else>
											<option value="${dic.id}" />${dic.name}</option>
										</#if>
									</#list>
								<#else>
									<#list dicRoleType as dic>
										<option  value="${dic.id}" />${dic.name}</option>
									</#list>
								</#if>
							</select>
						</div>
					</div>
					<div class="span5">
							<div class="span3">
								<label >角色状态<span class="f_req">*</span></label>
							</div>
							<div class="span9">
								<select size="1" id="status" name="status" aria-controls="dt_gal"  class="span6">
									<#if role.id?? >
										<#list dicStatus as dic>
												<#if dic.id==role.statusDic.id >
													<option value="${dic.id}" selected="selected">${dic.name}</option>
												<#else>
													<option value="${dic.id}" >${dic.name}</option>
												</#if>
										</#list> 
									<#else>
										<#list dicStatus as dic>
												<#if dic_index==0>
													<option value="${dic.id}" selected="selected">${dic.name}</option>
												<#else>
													<option value="${dic.id}" >${dic.name}</option>
												</#if>
										</#list>
									</#if>
								</select>
							</div>
						</div>
				</div>
			</div>
			
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
							<label>用户</label>
						</div>
						<div class="span9">
							<input id="_userIds" name="userIds" type="hidden" class="span6" value="${(userIds!"")?html}"/>
							<textarea name="userNames" id="_userNames" cols="12" rows="5" class="span10" readonly="true">${(userNames!"")?html}</textarea>
							<button class="btn btn-info" type="button" onclick="selectUser()">选择</button>
						</div>
					</div>
				</div>
			</div>
						
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
							<label >备注 </label>
						</div>
						<div class="span9">
							<textarea name="comments" id="comments" cols="40" rows="5" 
							 class="{maxlength:500} span12" >${(role.comments!"")?html}</textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="span6">
	        	<p class="btnMargin">
					<button class="btn btn-info" type="button" onclick="onSub()">确 定</button>
					<button class="btn" type="button" onclick="cancel()">取消</button>
				</p>
			</div>
			
		</form>
		<input name="check_error" id="check_error" type="hidden" value="true"/>
	</div>
</div>
<#include "/user/comp/queryUserCheckboxModal.ftl">
<script>
	function cancel(){
		window.location.href="${rc.contextPath}/user/role/opt-query/roleList.do";
	}
	function onSub(){
		var check_error=$("#check_error").val();
		if(check_error == "true"){
			$('#roleForm').submit();
		}
	}
	
		function selectUser(){
			_initValues($("#_userIds").val());
			_queryUserSubmit();		
			comp.showModal("_selectUserModal");
		}
		
		function _getUsers(){

			comp.hideModal("_selectUserModal");
			$("#_userIds").val(_getUserIds());		
			$("#_userNames").html(_getUserNames());	
			
		}
	
	$("document").ready(function(){
		$('.form_validation_reg').validate({
				onkeyup: false,
				errorClass: 'error',
				validClass: 'valid',
				focusCleanup:true,
				focusInvalid:false,
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
	
        jQuery.validator.addMethod("namecheck", function(value,element) {
			var optionalval = this.optional(element);
			var returnval;
			$.ajax({
				url:"${rc.contextPath}/user/role/opt-query/checkAttribute.do",
				async:false,
				cache: false,
				type: "POST",
				data:{type:"name",val:$('#name').val(),id:$('#id').val()},
				success: function(msg){
			    	returnval = optionalval||(msg=='success');
			   }
			});
			return returnval;
		}, "角色名称重复");
		
		jQuery.validator.addMethod("codecheck", function(value,element) {
			var optionalval = this.optional(element);
			var returnval;
			$.ajax({
				url:"${rc.contextPath}/user/role/opt-query/checkAttribute.do",
				async:false,
				cache: false,
				type: "POST",
				data:{type:"code",val:$('#code').val(),id:$('#id').val()},
				success: function(msg){
			    	returnval = optionalval||(msg=='success');
			   }
			});
			return returnval;
		 }, "角色编码重复");
        
        
        if($('#errorText').val()!=""){
        	$.sticky($('#errorText').val(), {autoclose : 5000, position: "top-right", type: "st-error" });
        }
	});
	
	 </script>
</body>
</html>
