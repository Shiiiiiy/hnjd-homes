<html>
<title>form elements</title>
<head>
<!--ztree-->
	<link rel="stylesheet" href="${rc.contextPath}/css/bdp_comp.css" type="text/css">
	<link rel="stylesheet" href="${rc.contextPath}/lib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
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
	<script src="${rc.contextPath}/js/jquery.form.js"></script>
	<script>
	
	function goToList(){
		window.location.href="${rc.contextPath}/user/user/opt-query/queryUser.do";
	}
	
	$(document).ready(function () {
		comp.initTree("orgPosTree","${rc.contextPath}/user/comp/getOrgTree.do",null,null,getPositionTree);
		comp.orgSingleSelect("orgTree");
		
		var orgPositionOrgId= $("#orgPositionOrgId").val();
		var orgPositionId= $("#orgPositionId").val();
		if(orgPositionId!=""){
			comp.initTree("positionTree","${rc.contextPath}/user/comp/getPositionTree.do",{orgId:orgPositionOrgId},"");
		}
		
	});
	//组织机构选择
	function selectOrg(){
		$("#orgError").empty();//若页面上有不能为空的提示语，点击选择先清空提示语
		var pureOrgId= $("#pureOrgId").val();
		var orgTree= $.fn.zTree.getZTreeObj("orgTree");
		if(pureOrgId!=""){
			var orgNode = orgTree.getNodeByParam("id",pureOrgId, null);
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
		var pureOrgId=treeObj.getSelectedNodes()[0].id;
		$("#orgName").val(orgName);
		$("#orgNameText").val(orgName);
		$("#pureOrgId").val(pureOrgId);
		var level=treeObj.getSelectedNodes()[0].level;
		if(level==0){
			$("#orgName").val("");
			$("#pureOrgId").val("");
			$.sticky("不能选择顶级组织机构", {autoclose : 5000, position: "top-right", type: "st-error" });
		}else{
			comp.hideModal("orgModal");
		}
	}
	
	
	<!----------------岗位begin----------->
	//组织机构选择岗位
	function getPositionTree(){
		var id=comp.returnTreeValue("orgPosTree","sel")[0].id;//选择岗位时弹出窗口里面的组织结构id
		comp.initTree("positionTree","${rc.contextPath}/user/comp/getPositionTree.do",{orgId:id},"");
	}
	
	function selectPosition(){
		$("#positionError").empty();//若页面上有不能为空的提示语，点击选择先清空提示语
		var orgTree= $.fn.zTree.getZTreeObj("orgPosTree");
		var posTree= $.fn.zTree.getZTreeObj("positionTree");
		
		var orgPositionOrgId= $("#orgPositionOrgId").val();
		var orgPositionId= $("#orgPositionId").val();
		if(orgPositionId!=""){
			var orgNode = orgTree.getNodeByParam("id", orgPositionOrgId, null);
			orgTree.selectNode(orgNode);
			var posNode = comp.getTreeObj("positionTree").getNodeByParam("id", orgPositionId, null);
			posTree.selectNode(posNode);
			posTree.expandAll(true);
		}else{
			var nodes = orgTree.getSelectedNodes();
			for(var i=0;i<nodes.length;i++){
				orgTree.cancelSelectedNode(nodes[i]);
			}
			if(posTree!=null){
				comp.getTreeObj("positionTree").destroy();
			}
		}
		
		comp.showModal("positionModal");
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
		$('#positionNameText').val(positionName);
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

	<!----------------岗位end----------->
	<!----------------用户  begin----------->
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
	<!----------------用户  end----------->
	function onSub(){
		if(vaildOrg() && vaildPosition() && vaildUser()){
			$("#batchPosForm").submit();
		}
		 
	}
	//验证组织机构
	function vaildOrg(){
		var flag = true;
		if($("#pureOrgId").val()==""){
		 	$('#orgError').html("组织机构不能为空");
		 	flag=false;
		 }else{
			$("#orgError").empty();
		}
		
		return flag;
	}
	//验证岗位
	function vaildPosition(){
		var flag = true;
		if($("#orgPositionId").val()==""){
		 	$('#positionError').html("岗位不能为空");
		 	flag=false;
		 }else{
			$("#positionError").empty();
		}
		return flag;
	}
	//验证用户
	function vaildUser(){
		var flag = true;
		var userids = $("#_userIds").val();
		var userNames = $("#_userNames").text();
		if(userids =="" || userNames == ""){
			$('#userError').html("用户不能为空");
			flag=false;
		}
		return flag;
	}
	//当选择用户时清除用户不能为空的提示语
	function emptyUserHtml(){
		$("#userError").empty();
	}
	function getUserInfo(){
		var pureOrgId=$("#pureOrgId").val();
	    var orgPositionId=$("#orgPositionId").val();
	    if(pureOrgId!="" && orgPositionId!=""){
			$.ajax({
					async :false,
					cache :false,
					dataType :"text",
					type:"POST",
					timeout: 100000,
					url: "${rc.contextPath}/user/user/opt-query/getUsersJson.do",
					data:{"pureOrgId":pureOrgId,"orgPositionId":orgPositionId},
					error: function () {//请求失败处理函数
						comp.message("请求失败，请稍后再试","error");
						flag = false;
					},
					success:function(data){ //请求成功后处理函数。
						if(data!=null){
							var dataJson = jQuery.parseJSON(data);
							var userids = dataJson.userIds;
							var userNames = dataJson.userNames;
						 	$("#_userIds").attr("value",userids);
						 	$("#_userNames").html(userNames);
						}
					}
				});
			}
	}
	
</script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
    <input name="errorText" id="errorText" type="hidden" value="${errorText!""}"/>
    <h3 class="heading">批量设置岗位</h3>
    	
	<form  id="batchPosForm" class="form_validation_reg" action="${rc.contextPath}/user/user/opt-update/batchSaveUserPosition.do" method="post"><@token/>
		<div class="formSep">
			<div class="row-fluid">
				<div class="span8">
					<div class="span2">
						<label >组织机构 <span class="f_req">*</span></label>
					</div>
					<div class="span10">
						<input id="orgName" name="orgName"  disabled="disabled"  class="span4" value="${orgNameText!""}"/>
						<input id="orgNameText" name="orgNameText" class="span6" type="hidden"  value="${orgNameText!""}"/>
						<input id="pureOrgId" name="pureOrgId" type="hidden" value="${pureOrgId!""}"  />
						
						<a style="cursor:pointer" onclick="selectOrg()">选择</a>&nbsp;
						<br/>
						<span style="color:#C62626;font-size:11px;font-weight:700" id="orgError"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="formSep">
			<div class="row-fluid">
				<div class="span8">
					<div class="span2">
						<label >岗位 <span class="f_req">*</span></label>
					</div>
					<div class="span10">
						<input id="positionName" name="positionName"  disabled="disabled" value="${positionNameText!""}"  class="span4"/>
						<input id="positionNameText" name="positionNameText" class="span6" type="hidden"  value="${positionNameText!""}"/>
						<input id="orgPositionOrgId" name="orgPositionOrgId" type="hidden" value="${orgPositionOrgId!""}"  />
						<input id="orgPositionId" name="orgPositionId" type="hidden" value="${orgPositionId!""}"  />
						
						<a style="cursor:pointer" onclick="selectPosition()">选择</a>&nbsp;<br/>
						<span style="color:#C62626;font-size:11px;font-weight:700" id="positionError"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="formSep">
				<div class="row-fluid">
					<div class="span8">
						<div class="span2">
							<label>用户<span class="f_req">*</span></label>
						</div>
						<div class="span10">
							<input id="_userIds" name="userIds" type="hidden" class="span6" value="${(userIds!"")?html}"/>
							<textarea name="userNames" id="_userNames" cols="12" rows="5" class="span10" readonly="true">${(userNames!"")?html}</textarea>
							<button class="btn btn-info" type="button" onclick="selectUser();emptyUserHtml();">选择</button><br/>
						<span style="color:#C62626;font-size:11px;font-weight:700" id="userError"></span>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="span6">
			<p class="btnMargin">
				<button class="btn btn-info" type="button" onclick="onSub()">确 定</button>
				&nbsp;&nbsp;&nbsp;
			  	<button class="btn"  type="button" onclick="goToList();">返回</button>
			</p>
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
				<ul id="orgTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info"  onclick="getOrg();getUserInfo();">确定</a>
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
		<a href="#" class="btn btn-info"  onclick="getPosition();getUserInfo();">确定</a>
	</div>
</div>
<#include "/user/comp/queryUserCheckboxModal.ftl">
</body>

</html>

