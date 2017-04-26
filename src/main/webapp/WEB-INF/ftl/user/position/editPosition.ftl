<html>
<title>form elements</title>
<head>
<!--validata-->	
	<script src="${rc.contextPath}/js/jquery.metadata.js"></script>
	<script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
	<script src="${rc.contextPath}/js/myjs_message_cn.js"></script>
<!-- sticky messages -->
	<script src="${rc.contextPath}/lib/sticky/sticky.min.js"></script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
		<input name="errorText" id="errorText" type="hidden" value="${errorText!""}"/>
		<#if position?? && position.id?? >
			<h3 class="heading">修改岗位</h3>
			<form  id="positionForm" class="form_validation_reg" action="${rc.contextPath}/user/position/opt-update/savePosition.do" method="post">
		<#else>
			<h3 class="heading">新增岗位</h3>
			<form  id="positionForm" class="form_validation_reg" action="${rc.contextPath}/user/position/opt-add/savePosition.do" method="post"><@token/>
		</#if>
		<input id="id" type="hidden" name="id"  value="${(position.id)!""}">
					
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
							<label >岗位名称 <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<input id="name" name="name"  value="${(position.name)!""}" 
												class="{required:true,minlength:1,maxlength:30,namecheck:true,uwsnumcharcn:true,messages:{required:'岗位名称不能为空'}}" />
						</div>
					</div>
					<div class="span5">
						<div class="span3">
							<label >岗位编码 <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<input id="code" name="code"  value="${(position.code)!""}"
												class="{required:true,minlength:1,maxlength:32,uwsnumchar:true,codecheck:true,messages:{required:'岗位编码不能为空'}}" />
						</div>
					</div>
				</div>
			</div>
					
			<div class="formSep">
				<div class="row-fluid">
					<div class="span5">
						<div class="span3">
							<label >岗位等级  <span class="f_req">*</span></label>
						</div>
						<div class="span9">
							<select size="1" name="level" aria-controls="dt_gal" class="{required:true,messages:{required:'岗位等级不能为空'}}" >
								<option  value="" />请选择..</option>
								<#if position.id?? >
									<#list dicLevel as dic>
										<#if dic.id==position.levelDic.id >
											<option  value="${dic.id}" selected="selected" />${dic.name}</option>
										<#else>
											<option value="${dic.id}" />${dic.name}</option>
										</#if>
									</#list>
								<#else>
									<#list dicLevel as dic>
										<option  value="${dic.id}" />${dic.name}</option>
									</#list>
								</#if>
							</select>
						</div>
					</div>
				<div class="span5">
					<div class="span3">
						<label >岗位状态  <span class="f_req">*</span></label>
					</div>
					<div class="span9">
						<select size="1" id="status" name="status" aria-controls="dt_gal"  class="{required:true,messages:{required:'岗位状态不能为空'}}">
							<option  value="" />请选择..</option>
							<#if position.id?? >
								<#list dicStatus as dic>
										<#if dic.id==position.statusDic.id >
											<option value="${dic.id}" selected="selected">${dic.name}</option>
										<#else>
											<option value="${dic.id}" >${dic.name}</option>
										</#if>
								</#list> 
							<#else>
								<#list dicStatus as dic>
										<#if dic_index==0>
											<option value="${dic.id}">${dic.name}</option>
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
							<label >备注 </label>
						</div>
						<div class="span9">
							<textarea name="comments" id="comments" cols="40" rows="5" 
							class="{maxlength:500} span12"><#if position?? &&position.comments??>${(position.comments)?html}</#if></textarea>
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
<script>
	function cancel(){
		window.location.href="${rc.contextPath}/user/position/opt-query/positionList.do";
	}
	function onSub(){
		var check_error=$("#check_error").val();
		if(check_error == "true"){
			$('#positionForm').submit();
		}
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
				url:"${rc.contextPath}/user/position/opt-query/checkAttribute.do",
				async:false,
				cache: false,
				type: "POST",
				data:{type:"name",val:$('#name').val(),id:$('#id').val()},
				success: function(msg){
			    	returnval = optionalval||(msg=='success');
			   }
			});
			return returnval;
		}, "岗位名称重复");
		
		jQuery.validator.addMethod("codecheck", function(value,element) {
			var optionalval = this.optional(element);
			var returnval;
			$.ajax({
				url:"${rc.contextPath}/user/position/opt-query/checkAttribute.do",
				async:false,
				cache: false,
				type: "POST",
				data:{type:"code",val:$('#code').val(),id:$('#id').val()},
				success: function(msg){
			    	returnval = optionalval||(msg=='success');
			   }
			});
			return returnval;
		 }, "岗位编码重复");
        
        
        if($('#errorText').val()!=""){
        	$.sticky($('#errorText').val(), {autoclose : 5000, position: "top-right", type: "st-error" });
        }
	});
	
	 </script>
</body>
</html>
