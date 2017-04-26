<!DOCTYPE html>
<html lang="en">
    <head> 
    <title></title>
    <script>
    	function addUserGroup(){
			window.location.href="${rc.contextPath}/user/userGroup/opt-add/editUserGroup.do";
		}
		
		function del(id) {
			comp.confirm("确定要删除该用户组？",function(r){
				if(r){
					$.post("${rc.contextPath}/user/userGroup/opt-del/delUserGroup.do",{id:id},function(data) {
						if(data=='success') {
						   window.location.href="${rc.contextPath}/user/userGroup/opt-query/userGroupList.do";
						}
					},"text");
				}
			});
       	 	
        }
		
		function updateUserGroup(id){
			window.location.href="${rc.contextPath}/user/userGroup/opt-update/editUserGroup.do?id="+id;
    	}
		function startUserGroup(id){
        	$.ajax({
				url:"${rc.contextPath}/user/userGroup/opt-update/startUserGroup.do",
				async:false,
				cache: false,
				type: "POST",
				data:{id:id},
				success: function(data){
			    	var appName = data.name;
    				var userGroupId = data.id;
					$.sticky("用户组已启用！", {autoclose : 5000, position: "top-right", type: "st-info" });
					$("#"+userGroupId+"_status").attr("class","icon-green");
					$("#"+userGroupId+"_status").attr("title","已启用");
					$("#"+userGroupId+"_status_opt").attr("title","禁用");
					$("#"+userGroupId+"_status_opt").attr("onclick","stopUserGroup('"+userGroupId+"')");
					$("#"+userGroupId+"_status_opt").html("<i class=\"icon-stop\">");
			   },
			   error: function(){
			   		$.sticky("链接超时，请重试！", {autoclose : 5000, position: "top-right", type: "st-error" });
			   },
			   dataType:"json"
			});
        }
        function stopUserGroup(id){
        	$.ajax({
				url:"${rc.contextPath}/user/userGroup/opt-update/stopUserGroup.do",
				async:false,
				cache: false,
				type: "POST",
				data:{id:id},
				success: function(data){
			    	var appName = data.name;
    				var userGroupId = data.id;
					$.sticky("用户组已禁用！", {autoclose : 5000, position: "top-right", type: "st-info" });
					$("#"+userGroupId+"_status").attr("class","icon-red");
					$("#"+userGroupId+"_status").attr("title","已禁用");
					$("#"+userGroupId+"_status_opt").attr("title","启用");
					$("#"+userGroupId+"_status_opt").attr("onclick","startUserGroup('"+userGroupId+"')");
					$("#"+userGroupId+"_status_opt").html("<i class=\"icon-play\">");
			   },
			   error: function(){
			   		$.sticky("链接超时，请重试！", {autoclose : 5000, position: "top-right", type: "st-error" });
			   },
			   dataType:"json"
			});
        }
	</script>
		
		
    </head>
    <body>
    <div id="contentwrapper">
    <div class="main_content"> 
    	<div class="row-fluid">	
			<form  id="userGroupQuery"  action="${rc.contextPath}/user/userGroup/opt-query/userGroupList.do" method="post">
				<div class="span12">			
					<div class="row-fluid">
						<div class="span4">
							<span class="formTitle">名称</span>
							<#if userGroup.name?? >
								<input id="name" name="name" class="span6" value="${userGroup.name?html}" />
							<#else>
								<input id="name" name="name" class="span6"  />
							</#if> 
						</div>
						<div class="span4">
							<span class="formTitle">编码</span>
							<#if userGroup.code?? >
								<input id="code" name="code" class="span6" value="${userGroup.code?html}" />
							<#else>
								<input id="code" name="code" class="span6"  />
							</#if> 
						</div>
						<div class="span4">
							<span class="formTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
							<select size="1" id="status.id" name="status.id" aria-controls="dt_gal" class="span6">
								<option value="">请选择..</option>
								<#if userGroup.status?? >
									<#list statusList as status>
											<#if status.id==userGroup.status.id >
												<option value="${status.id}" selected="selected">${status.name}</option>
											<#else>
												<option value="${status.id}" >${status.name}</option>
											</#if>
									</#list>
								<#else>
									<#list statusList as status>
											<option value="${status.id}" >${status.name}</option>
									</#list> 
								</#if>
							</select>
						</div>
					</div>		
				</div>
	            <div class="btnCenter">
	              <button class="btn btn-info">查 询</button>
	            </div>
			</form>
			
			<div class="row-fluid">
				<div class="span12">
				  <h5 class="heading"></h5>	
					<div id="dt_gal_wrapper" class="dataTables_wrapper form-inline" role="grid">
				    	<div class="row">
			                 <div class="span6">
			            		<div class="dt_actions">
			                        <div class="btn-group">
			                        	<#if user_key.optMap??>
				                        	<#if user_key.optMap['add']??>
				            					<button class="btn btn-info" type="button" onclick="addUserGroup()">新 增</button>
				              				</#if>
										</#if>
			              			</div>
			                   </div>
			           		</div>
				        </div>
						<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
									<thead>
										<tr>
											<th width="8%">序号</th>
											<th>名称</th>
											<th>编码</th>
											<th>状态</th>
											<#if user_key.optMap['update']?? || user_key.optMap['del']??>
											<th>操作</th>
											</#if>
										</tr>
									</thead>
									<tbody>
										<#if page??>
										<#list page.result as userGroup>
										<tr>
											<td class="autocut">${userGroup_index + 1}</td>
											<td class="autocut">${userGroup.name!}</td>
											<td class="autocut">${userGroup.code!}</td>
											<td class="autocut"><#if userGroup.status??>${userGroup.status.name!}</#if></td>
											
											<#if user_key.optMap['update']?? || user_key.optMap['del']??>
											<td>
												<#if user_key.optMap['update']??>
													<a href="#" onclick="updateUserGroup('${userGroup.id}')" class="sepV_a" title="修改"><i class="icon-pencil"></i></a>
												</#if>
												<#if user_key.optMap['del']??>
													<a href="#" onclick="del('${userGroup.id}')" title="删除"><i class="icon-trash"></i></a>
												</#if>
											</td>
											</#if>
										</tr>
										</#list> 
										</#if>
									</tbody>
								</table>
								<#assign pageTagformId="userGroupQuery"/>
								<#include "/page.ftl" > 
					</div>
				</div>
			</div> 
		</div> 
	</div>
</div>
	
	</body>
</html>