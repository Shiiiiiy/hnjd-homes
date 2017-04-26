<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>ROD Panel</title>
        
        <!--ztree-->
		<link rel="stylesheet" href="${rc.contextPath}/css/bdp_comp.css" type="text/css">
		<link rel="stylesheet" href="${rc.contextPath}/lib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.core-3.5.js"></script>
		<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.excheck-3.5.js"></script>
		<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.exedit-3.5.js"></script>
		<!-- multiselect -->
   		<link rel="stylesheet" href="${rc.contextPath}/lib/multiselect/css/multi-select.css" />
		<script src="${rc.contextPath}/lib/multiselect/js/jquery.multi-select.min.js"></script>
		<script src="${rc.contextPath}/js/bdp_comp.js"></script>
		
		<script type="text/javascript">
	function viewUser(id){
		comp.showModal("viewuser","800px","-250px 0 0 -400px");
		$("#stmp_user").load("${rc.contextPath}/user/user/opt-query/nsm/viewUser.do",{"id":id},function(){});
	}

	function addUser(){
		window.location.href="${rc.contextPath}/user/user/opt-add/editUser.do";
	}
	function resetPassword(id){
		comp.confirm("确定要重置用户密码？",function(r){
			if(r){
				$.ajax({
					url:"${rc.contextPath}/user/user/opt-resetPassword/resetPassword.do",
					async:false,
					cache: false,
					type: "POST",
					data:{id:id},
					success: function(msg){
						if("success"==msg){
							comp.message("重置密码成功","info");
						}
				   }
				});	
			}
		})
	}

	$(function(){
		comp.orgSingleSelect("orgTree");
	});
	//组织机构选择
	function selectOrg(){
		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		if(treeObj.getSelectedNodes().length==0){
			var node = treeObj.getNodes()[0];
			treeObj.selectNode(node);
		}
		comp.showModal("orgModal");		
	}
	//组织机构清除选项
	function cleanOrg(){
		$("#userOrgName").val("");
		$("#userOrgNameText").val("");
		$("#userOrgId").val("");
		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		var node = treeObj.getNodes()[0];
		treeObj.selectNode(node);
		$('#isHideDiv').hide();
	}
	function getOrg(){
		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		var orgName=treeObj.getSelectedNodes()[0].name;
		var orgId=treeObj.getSelectedNodes()[0].id;
		var level=treeObj.getSelectedNodes()[0].level;
		if(level!=0){
			$("#userOrgName").val(orgName);
			$("#userOrgNameText").val(orgName);
			$("#userOrgId").val(orgId);
			
			comp.hideModal("orgModal");
			
			$('#isHideDiv').show();
		}else{
			$("#userOrgName").val("全部");
			$("#userOrgNameText").val("全部");
			$("#userOrgId").val("");
			
			comp.hideModal("orgModal");
			
			$('#isHideDiv').hide();
		}
		
	}
	//删除用户
	function delUser(id){
		comp.confirm("确定要删除？",function(r){
			if(r){
				$.ajax({
					url:"${rc.contextPath}/user/user/opt-del/delUser.do",
					async:false,
					cache: false,
					type: "POST",
					data:{id:id},
					success: function(msg){
						if("success"==msg){
							$("#userQuery").submit();
						}
				   }
				});	
			}
		})
	}
	function importUser(){
		window.location.href="${rc.contextPath}/user/user/opt-query/importUserInit.do";
	}
	
	function exportUser(){
		var pageTotalCount= $("#pageTotalCount").val();
		var exportSize= $("#exportSize").val();
		var patrn=/^[0-9]{1,20}$/; 
		if(exportSize==""){
			comp.message("请输入大于0的正整数","error");
		}else if(!patrn.exec(exportSize)){
			comp.message("请输入大于0的正整数","error");
		}else if(exportSize<1){
			comp.message("请输入大于0的正整数","error");
		}else if(exportSize>10000){
			comp.message("请输入小于等于10000的正整数","error");
		}else{
			comp.showModal("exportuser","500px","-250px 0 0 -250px");
			$("#export_user").load("${rc.contextPath}/user/user/opt-query/nsm/exportUserList.do?pageTotalCount="+pageTotalCount+"&exportSize="+exportSize);
		}
	}
	
	function exportDate(exportSize,exportPage){
		$("#userQuery").attr("action","${rc.contextPath}/user/user/opt-query/exportUser.do");
		var fo=$("#userQuery");
		if($("#userQuery_exportPage").length==0){
			fo.append($("<input>",{
				id:'userQuery_exportSize',
				type:'hidden',
				name:'userQuery_exportSize',
				val:exportSize
			}));
			fo.append($("<input>",{
				id:'userQuery_exportPage',
				type:'hidden',
				name:'userQuery_exportPage',
				val:exportPage
			}));
		}else{
			$("#userQuery_exportSize").val(exportSize);
			$("#userQuery_exportPage").val(exportPage);
		}
		fo.submit();
	}
	$(function () {
		if(!($("#userOrgName").val()!=null&&$("#userOrgName").val()!="" && $("#userOrgName").val()!="全部"))
			$('#isHideDiv').hide();
	});
	
	
	function userQuery(){
		$("#userQuery").attr("action","${rc.contextPath}/user/user/opt-query/queryUser.do");
		$("#userQuery").submit();
	}
	
	function batchPosition(){
		window.location.href="${rc.contextPath}/user/user/opt-query/batchPosition.do";
	}
</script>
		
		
    </head>
<body>
<div id="contentwrapper">
    <div class="main_content"> 
    	<div class="row-fluid">	
			<form  id="userQuery"  action="${rc.contextPath}/user/user/opt-query/queryUser.do" method="post">
				<div class="span12">			
					<div class="row-fluid">
						<div class="span3">
							<span class="formTitle">人员名称</span>
							<input id="userName" name="userName" class="span6" value="${(user.userName!"")?html}"  />
						</div>
						<div class="span5">
							<span class="formTitle">&nbsp;&nbsp;&nbsp;登录名</span>
							<input id="loginName" name="loginName" class="span6"  value="${(user.loginName!"")?html}" />
						</div>
						<div class="span4">
							<span class="formTitle">人员状态</span>
							<select size="1" id="userStatus" name="userStatus" aria-controls="dt_gal"  class="span5">
								<option value="">请选择..</option>
									<#list dicStatus as dic>
										<#if user.userStatus??>
											<#if user.userStatus==dic.id>
												<option value="${dic.id}" selected="selected">${dic.name}</option>
											<#else>
												<option value="${dic.id}" >${dic.name}</option>
											</#if>
										<#else>
											<option value="${dic.id}" >${dic.name}</option>
										</#if>
									</#list>
							</select>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span3">
							<span class="formTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;岗位</span>
							<select size="1" id="positionId" name="positionId" aria-controls="dt_gal"  class="span6">
								<option value="">请选择..</option>
								<#if allPosition??  >
									<#if  user.positionId?? >
										<#list allPosition as pos>
											<#if user.positionId==pos.id> 
												<option value="${pos.id}" selected="selected">${pos.name}</option>
											<#else>
												<option value="${pos.id}" >${pos.name}</option>
											</#if>
										</#list>
									<#else>
										<#list allPosition as pos>
											<option value="${pos.id}" >${pos.name}</option>
										</#list>
									</#if>
								</#if>
							</select>
						</div>
						<div class="span5">
							<span class="formTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性别</span>
							<select size="1" id="gender" name="gender" aria-controls="dt_gal"  class="span6">
								<option value="">请选择..</option>
								<#if dicGender??  >
									<#if  user.gender?? >
										<#list dicGender as gender>
											<#if user.gender==gender.id> 
												<option value="${gender.id}" selected="selected">${gender.name}</option>
											<#else>
												<option value="${gender.id}" >${gender.name}</option>
											</#if>
										</#list>
									<#else>
										<#list dicGender as gender>
											<option value="${gender.id}" >${gender.name}</option>
										</#list>
									</#if>
								</#if>
							</select>
						</div>
						<div class="span4">
							<span class="formTitle">用户类型</span>
							<select size="1" id="userTypeId" name="userTypeId" aria-controls="dt_gal"  class="span5">
								<option value="">请选择..</option>
								<#if userTypeList??  >
									<#if  user.userTypeId?? >
										<#list userTypeList as userType>
											<#if user.userTypeId==userType.id> 
												<option value="${userType.id}" selected="selected">${userType.name}</option>
											<#else>
												<option value="${userType.id}" >${userType.name}</option>
											</#if>
										</#list>
									<#else>
										<#list userTypeList as userType>
											<option value="${userType.id}" >${userType.name}</option>
										</#list>
									</#if>
								</#if>
							</select>
						</div>
						
					</div>
					<div class="row-fluid">
						
						<div class="span3">
							<span class="formTitle">组织机构</span>
							<input id="userOrgName"  class="span6" disabled="disabled" value="${userOrgNameText!""}"/>
							<input id="userOrgNameText" name="userOrgNameText" type="hidden" class="span6"  value="${userOrgNameText!""}"/>
							<input id="userOrgId" name="userOrgId" type="hidden" class="span6"  value="${user.userOrgId!""}"/>
							<!--
							<button class=" btn-info" type="button" onclick="selectOrg()">选择</button>
							-->
							<a style="cursor:pointer" onclick="selectOrg()">选择</a>&nbsp;							
							<a style="cursor:pointer" onclick="cleanOrg()">清除</a>
						</div>
						<div class="span5" id="isHideDiv">
							<span class="formTitle">包含下级</span>
								<select size="1" id="incSub" name="incSub" aria-controls="dt_gal"  class="span6">
									<#if "Y"==incSub>
										<option value="Y" selected="selected">是</option>
									<#else>
										<option value="Y" >是</option>
									</#if>
									<#if "N"==incSub>
										<option value="N" selected="selected">否</option>
									<#else>
										<option value="N" >否</option>
									</#if>
								</select>
						</div>
					</div>
				</div>
	            <div class="btnCenter">
	              <button type="button" class="btn btn-info" onclick="userQuery()">查 询</button>
	            </div>
			</form>
			
			<div class="row-fluid">
				<div class="span12">
				  <h5 class="heading"></h5>	
					<div id="dt_gal_wrapper" class="dataTables_wrapper form-inline" role="grid">
				    	<div class="row">
			                 <div class="span10">
			            		<div class="dt_actions">
			                       <div class="row-fluid">
			                        	<#if user_key.optMap??>
				                        	<#if user_key.optMap['add']??>
				            					<button class="btn btn-info" type="button" onclick="addUser()">新 增</button>
				              				</#if>
				              				<#if user_key.optMap['update']??>
				              					<button class="btn btn-info" type="button" onclick="batchPosition()">批量设置岗位</button>
				              				</#if>
				              				<#if user_key.optMap['import']??>
				            					&nbsp;&nbsp;<button class="btn btn-info" type="button" onclick="importUser()">Excel导入</button>
				              				</#if>
				              				<#if user_key.optMap['export']??>
				              					<div class="input-append">
				            					<span class="expsingle">单页导出条数:</span><input id="exportSize" name="exportSize" class="span3"  value="1000" title="单页导出条数" />
				            					&nbsp;<button class="btn btn-info" type="button" onclick="exportUser()">Excel导出</button>
				              					</div>
				              				</#if>
				              				
										</#if>
			              			</div>
			                   </div>
			           		</div>
				        </div>
						<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
							<thead>
								<tr>
									<th width="10%">序号</th>
									<th>人员名称</th>
									<th>登录名</th>
									<th>性别</th>
									<th>组织机构</th>
									<th>岗位</th>
									<th>用户类型</th>
									<th>人员状态</th>
									<th>手机号码</th>
									<#if user_key.optMap['update']?? || user_key.optMap['del']?? || user_key.optMap['resetPassword']??>
									<th>操作</th>
									</#if>
								</tr>
							</thead>
							<tbody>
							<#if page??>
								<#list page.result as user>
									<#assign col=user.userOrgVos?size/>
									<#if col!=0>
										<#assign rol="${user.userOrgVos?size}"/>
									<#else>	
										<#assign rol="1"/>
									</#if>
									<tr>
										<td rowspan="${rol}" >${user_index+1}</td>
										<td rowspan="${rol}"  class="autocut"><a href="###" onclick="viewUser('${user.id}')">${user.name}</a></td>
										<td rowspan="${rol}"  class="autocut">
											<#if user.userLogins?size!=0>
												<#list user.userLogins as ul>
													${ul.loginName}
												</#list>
											</#if>
										</td>
										<td rowspan="${rol}"  class="autocut">${(user.genderDic.name!"")?html}</td>
										
										<#if col!=0>
											<#list user.userOrgVos as uo>
												<td rowspan="1" class="autocut"  title="${uo.orgNamePath}">
													${uo.orgName}
												</td>
												<#break>
											</#list>
										<#else>	
											<td rowspan="${rol}" class="autocut" ></td>
										</#if>
										
										<#if col!=0>
											<#list user.userOrgVos as uo>
												<td rowspan="1" class="autocut" >
													${uo.positions}
												</td>
												<#break>
											</#list>
										<#else>	
											<td rowspan="${rol}" class="autocut" ></td>
										</#if>
										<td rowspan="${rol}"  ><#if user.userType?? >${(user.userType.name)!""}</#if></td>
										<td rowspan="${rol}"  >${(user.statusDic.name)!""}</td>
										<td rowspan="${rol}"  class="autocut">${(user.phone)!""}</td>
										<#if user_key.optMap['update']?? || user_key.optMap['del']?? || user_key.optMap['resetPassword']??>
											<td rowspan="${rol}">
												<#if user_key.optMap['update']??>
													<a href="${rc.contextPath}/user/user/opt-update/editUser.do?id=${user.id}" class="sepV_a" title="修改"><i class="icon-pencil"></i></a>
												</#if>
												<#if user_key.optMap['del']??>
													<a href="#" onclick="delUser('${user.id}')" title="删除"><i class="icon-trash"></i></a>
												</#if>
												<#if user_key.optMap['resetPassword']??>
													<#if user.userLogins?size!=0>
														<a href="#" onclick="resetPassword('${user.id}')" title="恢复初始密码"><i class="splashy-folder_classic_locked"></i> </a>
													</#if>
												</#if>
											</td>
										</#if>
									</tr>
									<#if col!=0>
										<#list user.userOrgVos as uo>
											<#if uo_index!=0>
												<tr>
													<td rowspan="1" title="${uo.orgNamePath}">
														${uo.orgName}
													</td>
													<td rowspan="1">
														${uo.positions}
													</td>
												</tr>
											</#if>
										</#list>
									</#if>
								</#list> 
							</#if>
							</tbody>
						</table>
						<#assign pageTagformId="userQuery"/>
								<#include "/page.ftl" > 
						<!--用于用户导出 -->
						<input id="pageTotalCount" name="pageTotalCount" type="hidden"  value="${page.totalCount}"/>
					</div>
				</div>
			</div> 
		</div> 
	</div>
</div>


<!--组织机构选择 -->
<div class="modal hide fade" id="orgModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3>组织机构选择</h3>
	</div>
	<div class="modal-body">
		<div class="row-fluid">
				<ul id="orgTree" class="ztree "></ul>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" data-dismiss="modal" onclick="getOrg()">确定</a>
	</div>
</div>

<div class="modal hide fade" id="viewuser">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">人员查看</h3>
	</div>
	<div class="modal-body" id="stmp_user">
		
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">关闭</a>
	</div>
</div>

<div class="modal hide fade" id="exportuser">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">导出用户</h3>
	</div>
	<div class="modal-body" id="export_user">
		
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">关闭</a>
	</div>
</div>

	</body>
</html>