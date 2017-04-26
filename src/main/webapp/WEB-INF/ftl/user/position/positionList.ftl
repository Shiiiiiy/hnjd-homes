<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ROD Panel</title>
		<script>
			function del(id){
				comp.confirm("确定要删除？",function(r){
					if(r){
						$.post("${rc.contextPath}/user/position/opt-del/delPosition.do",{id:id},function(data) {
						 if(data=='success') {
							window.location.href="${rc.contextPath}/user/position/opt-query/positionList.do";
						 }else{
						 	$.sticky("该岗位已在组织机构中引用,请先解除引用关系后再删除!", {autoclose : 5000, position: "top-right", type: "st-error" });
						 }
						},"text");
					}
				});
			}
			function addPosition(){
				window.location.href="${rc.contextPath}/user/position/opt-add/editPosition.do";
			}
		</script>
    </head>
<body>
<div id="contentwrapper">
    <div class="main_content"> 
    	<div class="row-fluid">	
    		<form  id="positionQuery"  action="${rc.contextPath}/user/position/opt-query/positionList.do" method="post">
				<div class="span12">			
					<div class="row-fluid">
						<div class="span4">
							<span class="formTitle">岗位名称</span>
							<#if position.name?? >
								<input id="name" name="name" class="span6" value="${position.name?html}" />
							<#else>
								<input id="name" name="name" class="span6"  />
							</#if> 
						</div>
						<div class="span4">
							<span class="formTitle">岗位等级</span>
							<select size="1" name="level" aria-controls="dt_gal" class="span5" >
								<option value="" />请选择..</option>
								<#if position.level?? >
									<#list dicLevel as dic>
										<#if dic.id==position.level >
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
						<div class="span4">
							<span class="formTitle">岗位状态</span>
								<select size="1" id="status" name="status" aria-controls="dt_gal"  class="span6">
									<option value="">请选择..</option>
										<#if position.status?? >
											<#list dicStatus as dic>
													<#if dic.id==position.status >
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
			            					<button class="btn btn-info" type="button" onclick="addPosition()">新 增</button>
			              				</#if>
			              			</div>
			                   </div>
			           		</div>
				        </div>
						<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
							<thead>
								<tr>
									<th width="10%">序号</th>
									<th>岗位名称</th>
									<th>岗位编码</th>
									<th>岗位等级</th>
									<th>岗位状态</th>
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
									<td class="autocut">${(p.levelDic.name!"")?html}</td>
									<td class="autocut">${(p.statusDic.name!"")?html}</td>
									<#if user_key.optMap['update']?? || user_key.optMap['del']??>
										<td >
											<#if user_key.optMap['update']??>
												<a href="${rc.contextPath}/user/position/opt-update/editPosition.do?id=${p.id}" class="sepV_a" title="修改"><i class="icon-pencil"></i></a>
											</#if>
											<#if user_key.optMap['del']??>
												<a href="#" onclick="del('${p.id}')" title="删除11"><i class="icon-trash"></i></a>
											</#if>
										</td>
									</#if>
								</tr>
								</#list> 
							</#if>
							</tbody>
						</table>
						<#assign pageTagformId="positionQuery"/>
						<#include "/page.ftl" >
					</div>
				</div>
			</div> 
		</div> 
	</div>
</div>


	</body>
</html>