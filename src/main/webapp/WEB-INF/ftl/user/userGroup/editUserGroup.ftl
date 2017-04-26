<html>
<title></title>
<head>
<script src="${rc.contextPath}/js/jquery.form.js"></script>
</head>
<body>
	<div id="contentwrapper">
	    <div class="main_content">
	    	<div class="row-fluid">
		   		 <div class="span12">
			    	<h3 class="heading">
						<#if userGroup?? && userGroup.id?? >
							修改用户组
						<#else>
							新增用户组
						</#if>
					</h3>
			    </div>
	    	</div>
		
			<form  id="userGroupForm" class="form_validation_reg" 
			<#if userGroup?? && userGroup.id?? >
				action="${rc.contextPath}/user/userGroup/opt-update/submitUserGroup.do" 
			<#else>
				action="${rc.contextPath}/user/userGroup/opt-add/submitUserGroup.do"
			</#if>
			method="post">
			<#if userGroup?? && userGroup.id?? >
			<#else>
				<@token/>
			</#if>
			<input id="id" type="hidden" name="id"  value="${(userGroup.id)!""}">
					
			<div class="formSep">
				<div class="row-fluid">
					<div class="span8">
						<div class="span2">
							<label>名称 <span class="f_req">*</span></label>
						</div>
						<div class="span10">
							<input id="name" name="name"  value="${(userGroup.name)!}" />
						</div>
					</div>
				</div>
			</div>
			
			<div class="formSep">
				<div class="row-fluid">
					<div class="span8">
						<div class="span2">
							<label>编码 <span class="f_req">*</span></label>
						</div>
						<div class="span10">
							<input id="code" name="code"  value="${(userGroup.code)!""}"/>
						</div>
					</div>
				</div>
			</div>	
			<div class="formSep">
				<div class="row-fluid">
					<div class="span8">
						<div class="span2">
							<label>状态 <span class="f_req">*</span></label>
						</div>
						<div class="span10">
								<select size="1" id="statusId" name="statusId" aria-controls="dt_gal">
								<#if statusList??>
									<#if userGroup?? && userGroup.status?? && userGroup.status.id??>
										<#list statusList as status>
											<#if userGroup.status.id==status.id >
												<option  value="${status.id}" selected="selected" />${status.name?html}</option>
											<#else>
												<option value="${status.id}" />${status.name?html}</option>
											</#if>
										</#list>
									<#else>
										<#list statusList as status>
											<#if statusDisable?? && status.id==statusDisable.id >
												<option  value="${status.id}" selected="selected" />${status.name?html}</option>
											<#else>
												<option value="${status.id}" />${status.name?html}</option>
											</#if>
										</#list>
									</#if>
								</#if>
							 </select>
						</div>
					</div>
				</div>
			</div>
			<div class="formSep">
				<div class="row-fluid">
					<div class="span8">
						<div class="span2">
							<label>用户</label>
						</div>
						<div class="span10">
							<input id="_userIds" name="userIds" type="hidden" class="span6" value="${(userIds!"")?html}"/>
							<textarea name="userNames" id="_userNames" cols="12" rows="5" class="span10" readonly="true">${(userNames!"")?html}</textarea>
							<button class="btn btn-info" type="button" onclick="selectUser()">选择</button>
						</div>
					</div>
				</div>
			</div>
			<div class="span6">
	        	<p class="btnMargin">
	        		<button class="btn btn-info" type="submit">确定</button>
			  		<button class="btn" type="button" onclick="cancel()">取消</button>
				</p>
			</div>
			</form>
		</div>
	</div>
	<#include "/user/comp/queryUserCheckboxModal.ftl">
	<script>
		function cancel(){
			window.location.href="${rc.contextPath}/user/userGroup/opt-query/userGroupList.do";
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
		function onSub(){
			var check_error=$("#check_error").val();
			if(check_error == "true"){
				$('#optForm').submit();
			}
		}
		$('#userGroupForm').compValidate({
			onkeyup: false,
			onfocusout: function(element) {if ($(element).val()) $(element).valid(); },
			debug:false,
			errorClass: 'error',
			validClass: 'valid',
			focusCleanup:true,
			focusInvalid:false,
			rules: {
				name: { 
					required: true,
					minlength:1,
					maxlength:10,
					uwsnumcharcn:true,
					remote:{
	　　 				type:"POST",
	　　 				url:"${rc.contextPath}/user/userGroup/opt-query/checkUserGroupByName.do",
	　　 				data:{
	　　 					name:function(){return $("#name").val();},
							id:function(){return $("#id").val();}
	　　 				}
　　 				} 
				},
				code: { 
					required: true,
					minlength:1,
					maxlength:10,
					uwsnumchar:true,
					remote:{
	　　 				type:"POST",
	　　 				url:"${rc.contextPath}/user/userGroup/opt-query/checkUserGroupByCode.do",
	　　 				data:{
	　　 					code:function(){return $("#code").val();},
							id:function(){return $("#id").val();}
	　　 				}
　　 				} 
				}
			},
			messages: {
				name: {required:$.format("名称不能为空."),remote:$.format("名称已经存在.")},
				code: {required:$.format("编码不能为空."),remote:$.format("编码已经存在.")}
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
	        
	 </script>
	 
</body>
</html>
