<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ROD Panel</title>
		<script>
			function del(id){
				
				comp.confirm("角色删除后引用该角色的组织机构和用户将不具有该角色！确定要删除？",function(r){
					if(r){
						$.post("${rc.contextPath}/user/role/opt-del/delRole.do",{id:id},function(data) {
							if(data=='success') {
							   window.location.href="${rc.contextPath}/user/role/opt-query/roleList.do";
							}
						},"text");
					}
				});
			}
			
			function addRole(){
				window.location.href="${rc.contextPath}/user/role/opt-add/editRole.do";
			}
		</script>
    </head>
<body>
<div id="contentwrapper">
    <div class="main_content"> 
    	<div class="row-fluid">	
    		<form  id="roleQuery"  action="${rc.contextPath}/user/role/opt-query/roleList.do" method="post">
				<div class="span12">			
					<div class="row-fluid">
						<div class="span4">
							<span class="formTitle">角色名称</span>
							<#if role.name?? >
								<input id="name" name="name" class="span6" value="${role.name?html}" />
							<#else>
								<input id="name" name="name" class="span6"  />
							</#if> 
						</div>
						<div class="span4">
							<span class="formTitle">角色类型</span>
							<select size="1" name="type" aria-controls="dt_gal" class="span5" >
								<option value="">请选择..</option>
								<#if role.type?? >
									<#list dicRoleType as dic>
										<#if dic.id==role.type >
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
						<div class="span4">
							<span class="formTitle">角色状态</span>
								<select size="1" id="status" name="status" aria-controls="dt_gal"  class="span5">
									<option value="">请选择..</option>
										<#if role.status?? >
											<#list dicStatus as dic>
													<#if dic.id==role.status >
														<option value="${dic.id}" selected="selected">${dic.name}</option>
													<#else>
														<option value="${dic.id}" >${dic.name}</option>
													</#if>
											</#list>
										<#else>
											<#list dicStatus as dic>
													<option value="${dic.id}" >${dic.name}</option>
											</#list> 
										</#if>
								</select>
								
						</div>
					</div>
					
		            <div class="btnCenter">
		              <button class="btn btn-info">查 询</button>
		            </div>
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
		                        	<#if user_key.optMap['add']??>
	                					<button class="btn btn-info" type="button" onclick="addRole()">新 增</button>
		              				</#if>
		              			</div>
		                   </div>
		           </div>
		        </div>
				<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
					<thead>
						<tr>
							<th width="10%">序号</th>
							<th>角色名称</th>
							<th>角色编码</th>
							<th>角色类型</th>
							<th>角色状态</th>
							<#if user_key.optMap['update']?? || user_key.optMap['del']??>
								<th>操作</th>
							</#if>
						</tr>
					</thead>
					<tbody>
					<#if page??>
						<#list page.result as p>
						<tr>
							<td class="autocut">${p_index+1}</td>
							<td class="autocut">${p.name}</td>
							<td class="autocut">${p.code}</td>
							<td class="autocut">${(p.roleTypeDic.name!"")?html}</td>
							<td class="autocut">${(p.statusDic.name!"")?html}</td>
							<#if user_key.optMap['update']?? || user_key.optMap['del']??>
								<td >
									<#if user_key.optMap['update']??>
										<a href="${rc.contextPath}/user/role/opt-update/editRole.do?id=${p.id}" class="sepV_a" title="修改"><i class="icon-pencil"></i></a>
									</#if>
									<#if user_key.optMap['del']??>
										<a href="#" onclick="del('${p.id}')" title="删除"><i class="icon-trash"></i></a>
									</#if>
								</td>
							</#if>
						</tr>
						</#list> 
					</#if>
					</tbody>
				</table>
				<#assign pageTagformId="roleQuery"/>
								<#include "/page.ftl" > 
			</div>
				</div>
			</div> 
		</div> 
	</div>
</div> 


	</body>
</html>