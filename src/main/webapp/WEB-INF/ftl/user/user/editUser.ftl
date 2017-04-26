<html>
<title>form elements</title>
<head>
<!--ztree-->
	<link rel="stylesheet" href="${rc.contextPath}/css/bdp_comp.css" type="text/css">
	<link rel="stylesheet" href="${rc.contextPath}/lib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" href="${rc.contextPath}/lib/My97DatePicker/skin/WdatePicker.css" />
	<script language="javascript" type="text/javascript" src="${rc.contextPath}/lib/My97DatePicker/WdatePicker.js"></script>	
	<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.exedit-3.5.js"></script>
<!--validata-->	
	<script src="${rc.contextPath}/js/jquery.metadata.js"></script>
	<script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
	<script src="${rc.contextPath}/js/myjs_message_cn.js"></script>
<!-- sticky messages -->
	<script src="${rc.contextPath}/lib/sticky/sticky.min.js"></script>
	
	<!-- multiselect -->
    <link rel="stylesheet" href="${rc.contextPath}/lib/multiselect/css/multi-select.css" />
	<script src="${rc.contextPath}/lib/multiselect/js/jquery.multi-select.min.js"></script>
	
	<script src="${rc.contextPath}/js/bdp_comp.js"></script>
	<script src="${rc.contextPath}/js/rod_vaildCard.js"></script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
    <div class="row-fluid" style="margin-top:10px;">
	   		<div class="span9">
	   		<#if user.id?? >
				<h3 class="titleClass">修改用户</h4>
			<#else>
				<h3 class="titleClass">新增用户</h4>
			</#if>
	    	</div>
	    	<div class="span3" style="text-align:right;">
	    		<button class="btn" type="button" onclick="goToList()">返回列表</button>
			</div>
    	</div>
		<h3 class="heading"></h3>
    		
		<div class="tabbable ">
			<ul class="nav nav-tabs">
				<#if user.id?? >
					<li class="active"><a href="#user" id="user_tab" data-toggle="tab">基本信息</a></li>
					<li ><a href="#login" id="login_tab" data-toggle="tab" >维护账号</a></li>
					<li><a href="#user_role"  id="user_role_tab" data-toggle="tab">维护角色</a></li>
					<li><a href="#user_group"  id="user_group_tab" data-toggle="tab">维护用户组</a></li>
					<li><a href="#user_position"  id="user_position_tab" data-toggle="tab">维护岗位</a></li>
				<#else>
					<li class="active"><a href="#tab1" data-toggle="tab">基本信息</a></li>
					<li ><a href="#login" id="login_tab" onclick="disabeOther()" ><span style="color:#CDC9A5">维护账号</span></a></li>
					<li><a href="#user_role"  id="user_role_tab" onclick="disabeOther()" ><span style="color:#CDC9A5">维护角色</span></a></li>
					<li><a href="#user_group"  id="user_group_tab" onclick="disabeOther()" ><span style="color:#CDC9A5">维护用户组</span></a></li>
					<li><a href="#user_position"  id="user_position_tab" onclick="disabeOther()"><span style="color:#CDC9A5">维护岗位</span></a></li>
				</#if>
			</ul>
			<!-- 用户基本信息-->
			<div class="tab-content">
				<div class="tab-pane active" id="user">
					<input name="errorText" id="errorText" type="hidden" value="${errorText!""}"/>
					<#if user.id?? >
						<form  id="userForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-update/saveUser.do" method="post">
					<#else>
						<form  id="userForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-add/saveUser.do" method="post" ><@token/>
					</#if>
					<input id="id" type="hidden" name="id"  value="${(user.id)!""}">
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3" >
										<label class="control-label">人员名称 <span class="f_req">*</span></label>
									</div>
									<div class="span9">
										<input id="name" name="name"  value="${(user.name)!""}" />
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >性别</label>
									</div>
									<div class="span9">
										<#if user.genderDic?? >
											<#list dicGendere as dic>
												<label class="radio inline">
													<#if dic.id==user.genderDic.id >
														<input type="radio" value="${dic.id}" name="genderDic.id"  class="{required:true}" checked="checked"/>&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
													<#else>
														<input type="radio" value="${dic.id}" name="genderDic.id"  class="{required:true}" />&nbsp;${dic.name}
													</#if>
												</label>
											</#list> 
										<#else>
											<#list dicGendere as dic>
												<label class="radio inline">
													<#if dic_index==0>
														<input type="radio" value="${dic.id}" name="genderDic.id"  checked="checked" class="{required:true}" />&nbsp;${dic.name} &nbsp;&nbsp;&nbsp;
													<#else>
														<input type="radio" value="${dic.id}" name="genderDic.id"  class="{required:true}" />&nbsp;${dic.name}
													</#if>
												</label>
											</#list> 
										</#if>
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >用户类型 <span class="f_req">*</span></label>
									</div>
									<div class="span9">
										<select size="1" id="userTypeId" name="userTypeId" aria-controls="dt_gal"  >
											<option  value="" />请选择..</option>
											<#if user.userType?? >
												<#list userTypeList as dic>
													<#if dic.id==user.userType.id >
														<option  value="${dic.id}" selected="selected" />${dic.name}</option>
													<#else>
														<option value="${dic.id}" />${dic.name}</option>
													</#if>
												</#list>
											<#else>
												<#list userTypeList as dic>
													<option  value="${dic.id}" />${dic.name}</option>
												</#list>
											</#if>
										</select>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >人员状态</label>
									</div>
									<div class="span9">
										<#if user.id?? >
											<#list dicStatus as dic>
													<#if dic.id==user.statusDic.id >
														<label class="radio inline">
															<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" checked="checked"/>&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
														</label>
													<#else>
														<label class="radio inline">
															<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" />&nbsp;${dic.name}
														</label>
													</#if>
											</#list> 
										<#else>
											<#list dicStatus as dic>
													<#if dic_index==0>
														<label class="radio inline">
															<input type="radio" value="${dic.id}" name="statusDic.id"  checked="checked" class="{required:true}" />&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
														</label>
													<#else>
														<label class="radio inline">
															<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" />&nbsp;${dic.name}
														</label>
													</#if>
											</#list> 
										</#if>
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >证件类型 </label>
									</div>
									<div class="span9">
										<select size="1" id="certTypeId" name="certTypeDic.id" aria-controls="dt_gal"  >
											<option  value="" />请选择..</option>
											<#if user.certTypeDic?? >
												<#list dicCardType as dic>
													<#if dic.id==user.certTypeDic.id >
														<option  value="${dic.id}" selected="selected" />${dic.name}</option>
													<#else>
														<option value="${dic.id}" />${dic.name}</option>
													</#if>
												</#list>
											<#else>
												<#list dicCardType as dic>
													<option  value="${dic.id}" />${dic.name}</option>
												</#list>
											</#if>
										</select>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >证件号码</label>
									</div>
									<div class="span9">
										<input id="certNum" name="certNum" onblur="setBirthday();" value="${(user.certNum)!""}" />
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >出生日期</label>
									</div>
									<div class="span9">
										<input id="birthday" class="span6" name="birthday"  value="${(user.birthday)!""}" readonly onfocus="this.blur()" />
										<a href="#">
			                                <img onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${minDate!}',maxDate:'${maxDate!}',skin:'whyGreen',el:$dp.$('birthday')})" src="${rc.contextPath}/lib/My97DatePicker/skin/datePicker.gif" _fcksavedurl="${rc.contextPath}/lib/My97DatePicker/skin/datePicker.gif" width="22" height="28" align="absmiddle">
			                            </a>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >固定电话</label>
									</div>
									<div class="span9">
										<input id="tel" name="tel"  value="${(user.tel)!""}" />
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >手机号码</label>
									</div>
									<div class="span9">
										<input id="phone" name="phone"  value="${(user.phone)!""}" />
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >电子邮件</label>
									</div>
									<div class="span9">
										<input id="email" name="email"  value="${(user.email)!""}" />
									</div>
								</div>
							</div>
						</div>
						
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >家庭地址</label>
									</div>
									<div class="span9">
										<input id="address" name="address"  value="${(user.address!"")?html}" />
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >邮编</label>
									</div>
									<div class="span9">
										<input id="postcode" name="postcode"  value="${(user.postcode)!""}" />
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
										<textarea name="comments" id="comments" cols="80" rows="5" class="span12">${(user.comments!"")?html}</textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="span6">
				        	<p class="btnMargin">
								<button class="btn btn-info" >确 定</button>
								<button class="btn" type="button" onclick="goToList()">取消</button>
							</p>
						</div>
					</form>
				</div>
				
				<!-- 账号-->
				<div class="tab-pane" id="login"><@token/>
					<#if !userLogin.id??>
						<form  id="loginUserForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-add/saveLoginUser.do" method="post"><@token/>
					<#else>
						<form  id="loginUserForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-update/saveLoginUser.do" method="post">
					</#if>
					<div class="formSep">
						<div class="row-fluid">
							<div class="span5">
								<div class="span3">
									<label >登录名 <span class="f_req">*</span></label>
								</div>
								<div class="span9">
									<#if userLogin.id??>
										<input id="name" name="loginName"  value="${(userLogin.loginName)!""}" disabled="disabled" />
									<#else>
										<input id="name" name="loginName"  value="${(userLogin.loginName)!""}"  />
									</#if>
									<input  name="user.id" type="hidden"  value="${(user.id)!""}"  />
									<input  name="id" type="hidden"  value="${(userLogin.id)!""}"  />
								</div>
							</div>
						</div>
					</div>
					<#if !userLogin.id??>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >登录密码 <span class="f_req">*</span></label>
									</div>
									<div class="span9">
										<input id="password" name="password" type="password"  value="${(userLogin.password)!""}" />
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >确认登录密码 <span class="f_req">*</span></label>
									</div>
									<div class="span9">
										<input id="conpassword" name="conpassword" type="password"   value=""  />
									</div>
								</div>
							</div>
						</div>
					</#if>
					<div class="formSep">
						<div class="row-fluid">
							<div class="span5">
								<div class="span3">
									<label >账号状态 <span class="f_req">*</span></label>
								</div>
								<div class="span9 ">
									<#if userLogin.id?? >
										<#list loginStatus as dic>
												<#if dic.id==userLogin.statusDic.id >
													<label class="radio inline">
														<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" checked="checked"/>&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
													</label>
												<#else>
													<label class="radio inline">
														<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" />&nbsp;${dic.name}
													</label>
												</#if>
										</#list>
									<#else>
										<#list loginStatus as dic>
												<#if dic_index==0>
													<label class="radio inline">
													<input type="radio" value="${dic.id}" name="statusDic.id"  checked="checked" class="{required:true}" />&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
													</label >
												<#else>
													<label class="radio inline">
													<input type="radio" value="${dic.id}" name="statusDic.id"  class="{required:true}" />&nbsp;${dic.name}
													</label >
												</#if>
										</#list> 
									</#if>
								</div>
							</div>
						</div>
					</div>
					<div class="span6">
			        	<p class="btnMargin">
							<button class="btn btn-info" >确 定</button>
							<button class="btn" type="button" onclick="goToList()">取消</button>
						</p>
					</div>
					</form>
				</div>
				
				<!-- 角色-->
				<div class="tab-pane" id="user_role">
					<#if userRoleList??>
						<form  id="userRoleForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-update/saveUserRole.do" method="post"><@token/>
					<#else>
						<form  id="userRoleForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-add/saveUserRole.do" method="post">
					</#if>
						<input id="userid" name="userid" type="hidden"   value="${(user.id)!""}"  />
						<input id="roleIds" name="roleIds" type="hidden"   value=""  />
						
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5" id="searchable-form">
										<select name="countries[]" multiple="multiple" id="searchable-select" >
											<#if userRoleList??>
												<#if roleList??>
													<#list roleList as role>
														<#assign flage="false"> 
														<#list userRoleList as ur>
															<#if role.id==ur.role.id>
																<#assign flage="true"> 
															</#if>
														</#list>
														<#if flage="true">
															<option value="${role.id}" selected="selected" >${role.name}</option> 
														<#else>
															<option value="${role.id}" >${role.name}</option> 
														</#if>
													</#list>
												</#if>
											<#else>
												<#if roleList??>
													<#list roleList as role>
														<option value="${role.id}" >${role.name}</option> 
													</#list>
												</#if>
											</#if>
										</select>
								</div>
							</div>
						</div>
						<div class="span6">
				        	<p class="btnMargin">
								<button class="btn btn-info" type="button" onclick="roleSub()">确 定</button>
								<button class="btn" type="button" onclick="goToList()">取消</button>
							</p>
						</div>
					</form>
				</div>
				<!-- 用户组-->
				<div class="tab-pane" id="user_group">
					<#if userGroupList??>
						<form  id="userGroupForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-update/saveUserGroup.do" method="post"><@token/>
					<#else>
						<form  id="userGroupForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-add/saveUserGroup.do" method="post">
					</#if>
						<input id="userid" name="userid" type="hidden"   value="${(user.id)!""}"  />
						<input id="groupIds" name="groupIds" type="hidden"   value=""  />
						
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5" id="searchable-form-group">
										<select name="groups[]" multiple="multiple" id="searchable-select-group" >
											<#if userGroupList??>
												<#if groupList??>
													<#list groupList as group>
														<#assign flage="false"> 
														<#list userGroupList as up>
															<#if group.id==up.userGroup.id>
																<#assign flage="true"> 
															</#if>
														</#list>
														<#if flage="true">
															<option value="${group.id}" selected="selected" >${group.name}</option> 
														<#else>
															<option value="${group.id}" >${group.name}</option> 
														</#if>
													</#list>
												</#if>
											<#else>
												<#if groupList??>
													<#list groupList as group>
														<option value="${group.id}" >${group.name}</option> 
													</#list>
												</#if>
											</#if>
										</select>
								</div>
							</div>
						</div>
						<div class="span6">
				        	<p class="btnMargin">
								<button class="btn btn-info" type="button" onclick="groupSub()">确 定</button>
								<button class="btn" type="button" onclick="goToList()">取消</button>
							</p>
						</div>
					</form>
				</div>
				
				<!-- 岗位-->
				<div class="tab-pane" id="user_position">
					<form  id="userPositionForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-add/saveUserPosition.do" method="post">
						<div class="row-fluid">
							<div class="span12" id="userPositionTab">
							    <#include "positionList.ftl" > 
							</div>
						</div>
					</form>
				</div>
				
			</div>
		</div>
    
	</div>
</div>
<!--岗位选择 -->
<div class="modal hide fade" id="positionModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3>岗位选择</h3>
	</div>
	<div class="modal-body">
		<div class="row-fluid">
			<div class="span6">
				<ul id="orgPosTree" class="ztree myztree"></ul>
			</div>
			<div class="span3">
				<ul id="positionTree" class="ztree myztree"></ul>
			</div>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn " data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info"  onclick="getPosition()">确定</a>
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
				<ul id="orgTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info"  onclick="getOrg()">确定</a>
	</div>
</div>
<script>
	function goToList(){
		window.location.href="${rc.contextPath}/user/user/opt-query/queryUser.do";
	}
	function disabeOther(){
		$.sticky("请先填写用户基本信息并点击确定！", {autoclose : 5000, position: "top-right", type: "st-info" });
	}

	function positionList(){
		$("#userPositionTab").load("${rc.contextPath}/user/user/opt-query/nsm/userPositonList.do",{"userId":$("#id").val()},function(){});
	}
	function addPosition(){
		$("#userPositionTab").load("${rc.contextPath}/user/user/opt-add/nsm/editPosition.do",{"userId":$("#id").val()},function(){});
	}
	function editPosition(id,userId){
		$("#userPositionTab").load("${rc.contextPath}/user/user/opt-update/nsm/editPosition.do",{"id":id,"userId":userId},function(){});
	}
	function positionSub(){
		 var flage = false;
		 if($("#orgId").val()==""){
		 	$('#orgId').closest('div').removeClass("f_error");
			$('#orgId').closest('div').find('label').remove();
			$('#orgId').closest('div').addClass("f_error");
			$('#orgId').closest('div').append("<label class='error'>组织机构不能为空</label>");
		 	flage=true;
		 }
		 if($("#orgPositionId").val()==""){
		 	$('#orgPositionId').closest('div').removeClass("f_error");
			$('#orgPositionId').closest('div').find('label').remove();
			$('#orgPositionId').closest('div').addClass("f_error");
			$('#orgPositionId').closest('div').append("<label class='error'>岗位不能为空</label>");
		 	flage=true;
		 }
		 if(flage){
		 	return false;
		 }
		 var url="${rc.contextPath}/user/user/opt-add/saveUserPosition.do";
		 
		 if($("#userPositionId").val()!=""){
		 	url="${rc.contextPath}/user/user/opt-update/saveUserPosition.do";
		 }
		 
		 var val=$('input:radio[name="mainPos"]:checked').val();
		 $.ajax({
			url:url,
			async:false,
			cache: false,
			type: "POST",
			data:{orgId:$('#orgId').val(),orgPositionId:$('#orgPositionId').val(),userId:$('#id').val(),isMain:val,userPositionId:$("#userPositionId").val()},
			success: function(msg){
				if("success"==msg){
					$("#userPositionTab").load("${rc.contextPath}/user/user/opt-query/nsm/userPositonList.do",{"userId":$("#id").val()},function(){});
				}else if("isMain"==msg){
					$.sticky("该人员已经设置过主岗位,不能重复设置", {autoclose : 5000, position: "top-right", type: "st-error" });
				}else{
					$.sticky("该人员已经添加过相同的组织机构和岗位", {autoclose : 5000, position: "top-right", type: "st-error" });
				}
		   }
		});
		 
	}
	
	
	$(function(){
		comp.initTree("orgPosTree","${rc.contextPath}/user/comp/getOrgTree.do",null,null,getPositionTree);
		comp.orgSingleSelect("orgTree");
	});
	
	//组织机构选择
	function selectOrg(){
		var orgId= $("#orgId").val();
		var orgTree= $.fn.zTree.getZTreeObj("orgTree");
		if(orgId!=""){
			var orgNode = orgTree.getNodeByParam("id",orgId, null);
			orgTree.selectNode(orgNode);
		}else{
			var nodes = orgTree.getSelectedNodes();
			for(var i=0;i<nodes.length;i++){
				orgTree.cancelSelectedNode(nodes[i]);
			}
		}
		comp.showModal("orgModal");
	}
	function getOrg(){
		var treeObj = $.fn.zTree.getZTreeObj("orgTree");
		if(treeObj.getSelectedNodes().length==0){
			comp.message("请选择一个组织机构","error");
			return;
		}
		var orgName=treeObj.getSelectedNodes()[0].name;
		var orgId=treeObj.getSelectedNodes()[0].id;
		$("#orgName").val(orgName);
		$("#orgId").val(orgId);
		var level=treeObj.getSelectedNodes()[0].level;
		if(level==0){
			$("#orgName").val("");
			$("#orgId").val("");
			$.sticky("不能选择顶级组织机构", {autoclose : 5000, position: "top-right", type: "st-error" });
		}else{
			comp.hideModal("orgModal");
		}
	}
	//组织机构选择岗位
	function getPositionTree(){
		var id=comp.returnTreeValue("orgPosTree","sel")[0].id;
		comp.initTree("positionTree","${rc.contextPath}/user/comp/getPositionTree.do",{orgId:id},"");
	}
	
	function getPosition(){
		var treeObj = $.fn.zTree.getZTreeObj("orgPosTree");
		var positionTree= $.fn.zTree.getZTreeObj("positionTree");
		if(treeObj.getSelectedNodes().length==0){
			comp.message("请选择一个组织机构","error");
			return;
		}
		if(positionTree.getSelectedNodes().length==0){
			comp.message("请选择一个岗位","error");
			return;
		}
		
		var positionName=positionTree.getSelectedNodes()[0].name;
		var orgPositionId=positionTree.getSelectedNodes()[0].id;
		
		var pStatus= checkPositionStatus(orgPositionId);
		if(!pStatus){
			comp.message("该岗位已被禁用，不能使用","error");
			return;
		}
		
		$('#positionName').val(positionName);
		$('#orgPositionId').val(orgPositionId);
		comp.hideModal("positionModal");
	}
	
	function checkPositionStatus(orgPositionId){
		var flag=false;
		$.ajax({
			url:'${rc.contextPath}/user/user/opt-query/checkPositionStatus.do',
			async:false,
			cache: false,
			type: "POST",
			data:{orgPositionId:orgPositionId},
			success: function(msg){
				if("success"==msg){
					flag =true;
				}
		   }
		});
		return flag;
	}
	
	//获取系统角色
	function roleSub(){
		var v="";
		$("#searchable-select").each(
			function() {
			if (v != '') { v += ',' } v += $(this).val() }
		);
	    $('#roleIds').val(v);
	    $("#userRoleForm").submit();
	}
	//获取系统用户组
	function groupSub(){
		var v="";
		$("#searchable-select-group").each(
			function() {
			if (v != '') { v += ',' } v += $(this).val() }
		);
	    $('#groupIds').val(v);
	    $("#userGroupForm").submit();
	}
	
	function delPosition(id){
		comp.confirm("确定要删除？",function(r){
			if(r){
				$.ajax({
					url:"${rc.contextPath}/user/user/opt-del/delUserPosition.do",
					async:false,
					cache: false,
					type: "POST",
					data:{id:id},
					success: function(msg){
						if("success"==msg){
							$("#userPositionTab").load("${rc.contextPath}/user/user/opt-query/nsm/userPositonList.do",{"userId":$("#id").val()},function(){});
						}
				   }
				});	
			}
		})
	}
	
	multiselect = {
		init: function(){
			$('#searchable-form').multiSelect({ 
				selectableHeader : '<input type="text" type="button" value="选择角色"  style="width:160px" disabled="disabled"/></br><input type="text" id="sh" autocomplete="off" placeholder="搜索" style="width:160px"/>',
				selectedHeader	 : '<input type="text" type="button" value="已选角色"  style="width:160px" disabled="disabled"/></br><a href="javascript:void(0)" id="sForm_deselect" class="btn">全部移除</a>'
			});
			$('#sForm_deselect').on('click', function(){
				$('#searchable-form').multiSelect('deselect_all');
				return false;
			});
			$('input#sh').quicksearch('#ms-searchable-form .ms-selectable li');
			$('#searchable-form').multiSelect();

			$('#searchable-form-group').multiSelect({ 
				selectableHeader : '<input type="text" type="button" value="选择用户组"  style="width:160px" disabled="disabled"/></br><input type="text" id="sh_group" autocomplete="off" placeholder="搜索" style="width:160px"/>',
				selectedHeader	 : '<input type="text" type="button" value="已选用户组"  style="width:160px" disabled="disabled"/></br><a href="javascript:void(0)" id="sForm_deselect_group" class="btn" style="width:146px;margin-top:2px;" >全部移除</a>'
			});
			$('#sForm_deselect_group').on('click', function(){
				$('#searchable-form-group').multiSelect('deselect_all');
				return false;
			});
			$('input#sh_group').quicksearch('#ms-searchable-form-group .ms-selectable li');
			$('#searchable-form-group').multiSelect();
		}
	};

	jQuery.validator.addMethod("telCheck", function(value,element) {
			if(value!=""){
				var patrn=/^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$/; 
				return patrn.exec(value);
			}else{
				return true;
			}
		}, "请输入合法的座机号码");
	jQuery.validator.addMethod("loginNameCheck", function(value,element) {
			if(value!=""){
				var patrn=/^[A-Za-z0-9_]{1,32}$/; 
				return patrn.exec(value);
			}else{
				return true;
			}
		}, "登录名只能为数字,字母，下划线");

	$("document").ready(function(){
		
		$('#loginUserForm').validate({
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
                },
                rules: {
					loginName: {
						required: true,
						minlength:1,
						maxlength:30,
						uwsnumcharcn:true,
						remote:{
		　　 				type:"POST",
		　　 				url:"${rc.contextPath}/user/user/opt-query/checkloginUserName.do",
		　　 				data:{
		　　 					name:function(){return $("#loginName").val();}
		　　 				}
	　　 				}
					},
					password:{
						required: true,
						rangelength:[8,16]
					},
					conpassword:{
						required: true,
						rangelength:[8,16],
						equalTo:"#password"
					}
				},
				messages: {
					loginName: {required:$.format("登录名不能为空"),remote:$.format("登录名已经存在")},
					password: {required:$.format("登录密码不能为空")},
					conpassword: {required:$.format("确认登录密码不能为空"),equalTo:"两次密码输入不一致"}
				}
        });
		
		$('#userForm').validate({
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
                },
                rules: {
					name: {
						required: true,
						uwsnumcharcn:true,
						minlength:1,
						maxlength:30
					},
					userTypeId: {
						required: true
					},
					certNum:{
						maxlength:20
					},
					phone:{
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
					},
					comments:{
						maxlength:500
					}

				},
				messages: {
					name: {required:$.format("人员名称不能为空")},
					userTypeId: {required:$.format("用户类型不能为空")}
				}
        });
		
		
        
        if($('#errorText').val()!=""){
        	$.sticky($('#errorText').val(), {autoclose : 5000, position: "top-right", type: "st-error" });
        }
        
        $("#user_role_tab").parent().attr("class","");
        $("#user_group_tab").parent().attr("class","");
		$("#user_position_tab").parent().attr("class","");
		$("#login_tab").parent().attr("class","");
		$("#user_tab").parent().attr("class","");
		
		if("${tabActive}"=="user_role"){
			$('#user_role_tab').tab("show");
			$("#user_role_tab").parent().attr("class","active");
		}else if("${tabActive}"=="user_group"){
			$('#user_group_tab').tab("show");
			$("#user_group_tab").parent().attr("class","active");
		}else if("${tabActive}"=="user_position"){
			$('#user_position_tab').tab("show");
			$("#user_position_tab").parent().attr("class","active");
		}else if("${tabActive}"=="login"){
			$('#login_tab').tab("show");
			$("#login_tab").parent().attr("class","active");
		}else{
			$('#user_tab').tab("show");
			$("#user_tab").parent().attr("class","active");
		}
        
        multiselect.init();
        
        var saveInfo='${saveInfo!""}';
        if(saveInfo!='')
        	comp.message(saveInfo,"success");
	});
	
	function setBirthday(){
		//var certTypeId = $("#certTypeId").val();
		//alert(certTypeId);
		
		var certNum = $("#certNum").val();
		if(certNum !=null && certNum!=''){
			if(isCardID(certNum)==true){
				$("#birthday").val(getBirthday(certNum));
			}else{
				$("#birthday").val("");
			}
		
		}
		
		
	}
	 </script>
</body>
</html>
