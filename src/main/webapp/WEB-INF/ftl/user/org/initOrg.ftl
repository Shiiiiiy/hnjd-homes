<html>
<title>组织机构管理</title>
<head>
<!-- multiselect -->
    <link rel="stylesheet" href="${rc.contextPath}/lib/multiselect/css/multi-select.css" />
	<script src="${rc.contextPath}/lib/multiselect/js/jquery.multi-select.min.js"></script>
	<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.exhide-3.5.min.js"></script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span3">
					<div class="span12">
						<ul id="tree" class="ztree myztree"></ul>
					</div>
				</div>
				<div class="span9">
					<div class="row-fluid">
						<#if user_key.optMap['add']??>
						 	<button type="button" class="btn btn-info" onclick="popAddWin_()">增加下级</button>
						</#if>
						 &nbsp;&nbsp;&nbsp;
						<#if user_key.optMap['orgposition']??>
						 	<button type="button" class="btn btn-info" id="butPosition" onclick="positionManager()">岗位维护</button>
						</#if>
					</div>
					<div class="row-fluid">
						 <#include "childOrgList.ftl"> 
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 新增组织机构 -->
<div class="modal hide fade" id="addModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">新增组织机构</h3>
	</div>
	<div class="modal-body">
		<#include "addOrg.ftl">
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" id="sure" onclick="addOrgNode_()">确认</a>
	</div>
</div>

<!--编辑菜单页面-->
<div class="modal hide fade" id="editModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">编辑组织机构</h3>
	</div>
	<div class="modal-body">
		<p id="edittemp"></p>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" onclick="editOrgNode()">确认</a>
	</div>
</div>

<!--岗位维护页面-->
<div class="modal hide fade" id="editPositionModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">岗位维护</h3>
	</div>
	<div class="modal-body">
		<p id="editPosition"></p>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" onclick="editOrgNode()">确认</a>
	</div>
</div>
<!--调整弹出目标树-->
<div class="modal hide fade" id="treeModal" style="width: 330px;">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">选择目标组织机构</h3>
	</div>
	<div class="modal-body">
		<div class="span3">
			<ul id="targetTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-header">
		<span style="color:red">该操作不影响组织机构下的岗位结构，如有变动请手动调整。</span>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" onclick="moveOrg()">确认</a>
	</div>
</div>
<!--管理角色-->
<div class="modal hide fade" id="roleModal" style="width: 620px;">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">指定角色</h3>
	</div>
	<div class="modal-body">
		<div class="span6">
			<form id="searchable-form">
				<select name="countries[]" multiple="multiple" id="searchable-select" >
					<#if roleList??>
						<#list roleList as role>
							<option value="${role.id}" >${role.name}</option> 
						</#list>
					</#if>
				</select>
			</form>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" onclick="saveRole()">确认</a>
	</div>
</div>
<input type="hidden" id="moveCurTreeId">
<input type="hidden" id="orgId" >
<!--orgTreeId选择的树对应的菜单ID-->
<input type="hidden" id="orgTreeId">
<script>
//-----------------------------------------------------------------------------------
//-----------------------编辑区操作-----------------------------------------------------
//-初始化---------------
//树基本属性配置
			var setting = {
				view: {
					selectedMulti: false,
					dblClickExpand: true,
					showLine: true
				},
				data: {
					simpleData: {
						enable: true
						}
					},
				callback: {
					onClick: getChildOrgList
				}
			};
		//获取子菜单列表
		function getChildOrgList(e,treeId, Nodes){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			//treeObj.expandNode(Nodes);//单击展开父节点
			var nodes = treeObj.getSelectedNodes();//选择的节点对象
			$("#orgTreeId").val(nodes[0].id);
			if(nodes[0].level==0){
				$('#butPosition').hide();
			}else{
				$('#butPosition').show();
			}
			$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":nodes[0].id},function(){});
		}
		 //初始化新增页面
		 function popAddWin_(){
			clearAddValues();
			var treeObj = $.fn.zTree.getZTreeObj("tree");
		 	var nodes = treeObj.getSelectedNodes();
		 	if (nodes.length == 0) {
				//$("#fathermenu").html("");
				$.sticky("请选择一个组织机构进行操作", {autoclose : 5000, position: "top-right", type: "st-error" });
				return;
			}
			$("#pid").val(nodes[0].id);
			if(nodes[0].level!=0){
				$("#fathermenu").val(nodes[0].name);
			}else{
				$("#fathermenu").val("");
			}
			comp.showModal("addModal");
		 }
		 //初始化编辑页面
		 function popEditWin(id){
		 	
		 	clearEditValues();
			var treeObj = $.fn.zTree.getZTreeObj("tree");
		 	//$("#pid").val(id);
		 	
		 	$("#edittemp").load("${rc.contextPath}/user/org/opt-update/nsm/editOrgt.do",{"id":id},function(){
		 		initEditValidate();
		 		//$(".addOrgForm").compReset();
		 	});
			comp.showModal("editModal");
			
		 }
		 
//--操作-----------------------------
//增加组织机构时的验证
	var	nameUrl= "${rc.contextPath}/user/org/isExistByOrgName.do";
	var	codeUrl= "${rc.contextPath}/user/org/isExistByOrgCode.do";

	var addData={name:function(){return $("#name").val();},parent:function(){return $("#orgTreeId").val();},id:null};
	var codeData={code:function(){return $("#code").val();},id:null};
	
	comp.validate.addRemote("nameIsExsit",nameUrl,addData,"组织机构名称在同级中不能重复！");
	comp.validate.addRemote("codeIsExsit",codeUrl,codeData,"组织机构编码在系统中不能重复！");
	function initAddValidate(){
			$(".addOrgForm").compValidate({
				rules:{
					name: { 
							required: true, 
							minlength:1,
							maxlength: 30,
							uwsnumcharcn:true,
							nameIsExsit:true
							},
					code: {
							required: true, 
							minlength:1,
							maxlength: 20,
							uwsnumchar:true,
							codeIsExsit:true
							},
					area:{
						maxlength: 30
						},
					comments:{
						maxlength: 1500
						}
					},
				messages:{
					name:{required:$.format("名称不能为空")},
					code:{required:$.format("编码不能为空")}
					}
				});
		}
	//修改时的验证
		
		var eNameData={name:function(){return $("#name_").val();},parent:function(){return $("#parentid_").val();},id:function(){return $("#id_").val();}};
		var eCodeData={code:function(){return $("#code_").val();},id:function(){return $("#id_").val();}};
		comp.validate.addRemote("nameIsExsit_",nameUrl,eNameData,"组织机构名称在同级中不能重复！");
		comp.validate.addRemote("codeIsExsit_",codeUrl,eCodeData,"组织机构编码在系统中不能重复！");
		function initEditValidate(){
			$(".editMenuForm").compValidate({
				rules:{
					name_: { 
							required: true, 
							minlength:1,
							maxlength: 30,
							uwsnumcharcn:true,
							nameIsExsit_:true
							},
					code_: {
							required: true, 
							minlength:1,
							maxlength: 20,
							uwsnumchar:true,
							codeIsExsit_:true
							},
					area_:{
						maxlength: 30
						},
					comments_:{
						maxlength: 1500
						}
					},
					messages:{
						name_:{required:$.format("名称不能为空")},
						code_:{required:$.format("编码不能为空")}
					}
				});
		}
//增加节点
		function addOrgNode_(){
			clearValidateStyle("name");
			clearValidateStyle("code");
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getSelectedNodes();
			var pnode = nodes[0];
			var treeNode;
			var name=$("#name").val();
			var code=$("#code").val();
			var orgType=$("#orgType").val();
			var comments=$("#comments").val();
			var area=$("#area").val();
			
			if($(".addOrgForm").compValidator().form()){
				var url="${rc.contextPath}/user/org/opt-add/addOrg.do";
				var data={name:name,code:code,comments:comments,area:area,pId:pnode.id,orgType:orgType};
				
				$.ajax({
					async :false,
					cache :false,
					timeout: 100000,
					url: url,
					type: "POST",
					data:data,
					error: function () {//请求失败处理函数
						$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
						$('#addModal').modal('hide');
						return;
					},
					success:function(data){ //请求成功后处理函数。  
						if (pnode) {
							treeNode = treeObj.addNodes(pnode, {id:(data), pId:pnode.id,name:(name)});
						} else {
							treeNode = treeObj.addNodes(null, {id:(data), pId:null,name:(name)});
						}
						treeObj.refresh();
						treeObj.selectNode(pnode);
						$('#addModal').modal('hide');
						$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":nodes[0].id},function(){});
					}
				});
		}
	}
//删除菜单
		function delOrgNode(id){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var node = treeObj.getNodeByParam("id", id, null);
			var pnode=node.getParentNode();
			comp.confirm("您确定要删除"+node.name+"?",function(r){
				if(r){
					$.ajax({
						async :false,
						cache :false,
						dataType :"text",
						timeout: 100000,
						type: "POST",
						url: "${rc.contextPath}/user/org/opt-del/deleteOrg.do?id="+id,
						error: function () {//请求失败处理函数
							$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
							return;
						},
						success:function(data){ //请求成功后处理函数。
							if("success"==data){
								treeObj.removeNode(node);
								$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":pnode.id},function(){});
							}else{
								$.sticky("该组织机构已被人员、岗位引用或者存在子机构,请先解除关系后再删除!", {autoclose : 5000, position: "top-right", type: "st-error" });
							}
						}
					});
				}
			});
		}

		
	
//编辑菜单
		function editOrgNode(){
			//clearValidateStyle("name_");
			//clearValidateStyle("code_");
			
			var pId=$("#parentid_").val();
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var id=$("#id_").val();
			var name=$("#name_").val();
			var code=$("#code_").val();
			var area=$("#area_").val();
			var orgType=$("#orgType_").val();
			var comments=$("#comments_").val();
			var node = treeObj.getNodeByParam("id", id, null);
			
			if($(".editMenuForm").compValidator().form()){
				$.ajax({
					async :false,
					cache :false,
					timeout: 100000,
					type: "POST",
					url: "${rc.contextPath}/user/org/opt-update/updateOrg.do",
					data:{name:name,code:code,comments:comments,area:area,id:id,pId:pId,orgType:orgType},
					error: function () {//请求失败处理函数
						$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
						return;
					},
					success:function(data){ //请求成功后处理函数。  
						node.name=$("#name_").val();
						treeObj.updateNode(node);	
						$('#editModal').modal('hide');
						$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":pId},function(){});
					}
				});
		}
	}	
//上移
		function upTreeNode(id){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var node = treeObj.getNodeByParam("id", id, null);
			var pnode=node.getParentNode();
            if(node.isFirstNode){
                $.sticky("已移动到第一个节点，无法再次上移", {autoclose : 5000, position: "top-right", type: "st-error" });
                return;
            }
            var preNode = node.getPreNode();
             $.ajax({
				async :false,
				cache :false,
				type:"POST",
				dataType :"text",
				timeout: 100000,
				url: "${rc.contextPath}/user/org/opt-query/upDownOrg.do?sourceId="+node.id+"&targetId="+preNode.id,
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					treeObj.moveNode(preNode,node,"prev");
					$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":pnode.id},function(){});
				}
			});
            
		}
//下移
		function downTreeNode(id){
		 	var treeObj = $.fn.zTree.getZTreeObj("tree");
			var node = treeObj.getNodeByParam("id", id, null);
			var pnode=node.getParentNode();
            if(node.isLastNode){
                $.sticky("已移动到最后一个节点，无法再次下移", {autoclose : 5000, position: "top-right", type: "st-error" });
                return;
            }
            var preNode = node.getNextNode();
	         $.ajax({
				async :false,
				cache :false,
				type:"POST",
				dataType :"text",
				timeout: 100000,
				url: "${rc.contextPath}/user/org/opt-query/upDownOrg.do?sourceId="+node.id+"&targetId="+preNode.id,
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					treeObj.moveNode(preNode,node,"next");
					$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":pnode.id},function(){});
				}
			});
        }
//调整初始化页面
		function popMoveWin(id){
		 $("#moveCurTreeId").val(id);
		 	var Nodes;	
			$.ajax({
				async : false,
				cache:false,
				type: "POST",
				dataType : "json",
				url: "${rc.contextPath}/user/org/opt-query/initOrgData.do",
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
				},
				success:function(data){ //请求成功后处理函数。  
					Nodes = data;   //把后台封装好的简单Json格式赋给treeNodes
				}
			});
			$.fn.zTree.init($("#targetTree"), setting, Nodes);
			var treeObj = comp.getTreeObj("targetTree");
			var node = treeObj.getNodeByParam("id", id, null);
			treeObj.hideNode(node);
			comp.showModal("treeModal")
		 }
		 
//调整
        function moveOrg(){
            var id=$("#moveCurTreeId").val();
        	var curObj = $.fn.zTree.getZTreeObj("tree");//原对象
        	var targetObj = $.fn.zTree.getZTreeObj("targetTree");//目标对象
        	var targetNodes = targetObj.getSelectedNodes();//目标菜单

        	if(targetNodes==null || targetNodes.length<1){
        		comp.message("请选择目标组织机构","error");
        		return false;
        	}
        	var targetNode = curObj.getNodeByParam("id", targetNodes[0].id, null);//在原对象中找目标对象选择的菜单
        	var curNode = curObj.getNodeByParam("id", id, null);//原对象中的要调整的菜单
        	var pnode=curNode.getParentNode();
			
			if(curNode.id==targetNode.id){ //调整到自己
				comp.message("当前位置不需要调整","error");
				return false;
			}
			if(curNode.pId==targetNode.id){ //调整原来的父节点
				comp.message("当前位置不需要调整","error");
				return false;
			}
			
			if(isExistOrgName(curNode.name,targetNodes[0].id,null)=="false"){//同级组织机构名称重复验证
				comp.message("同级组织机构名称有重复，不能移动到该组织机构下","error");
				return false;
			}
			
			
			$.ajax({
				async :false,
				cache :false,
				dataType :"text",
				type:"POST",
				timeout: 100000,
				url: "${rc.contextPath}/user/org/opt-query/moveOrg.do",
				data:{sourceId:curNode.id,targetId:targetNode.id},
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					$.sticky("调整成功", {autoclose : 5000, position: "top-right", type: "st-info" });
					curObj.moveNode(targetNode, curNode, "inner");
	        		$('#treeModal').modal('hide');
	        		$("#smpl_tbl").load("${rc.contextPath}/user/orgChild/opt-query/getChildOrgList.do",{"id":pnode.id},function(){});
				}
			});
        }
//岗位维护		
		function positionManager(){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getSelectedNodes();
			if (nodes.length == 0) {
				$.sticky("请选择一个组织机构进行操作", {autoclose : 5000, position: "top-right", type: "st-error" });
				return;
			}
			var id=nodes[0].id;
			window.location.href="${rc.contextPath}/user/org/opt-query/positionManager.do?orgId="+id;
		}
//角色选择
		function roleWin(id){
			$('#orgId').val(id);
			$('#searchable-form').multiSelect('deselect_all');
			$.ajax({
				async : false,
				cache:false,
				type: "POST",
				dataType : "json",
				url: "${rc.contextPath}/user/org/opt-query/getOrgRole.do?id="+id,
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试!", {autoclose : 5000, position: "top-right", type: "st-error" });
				},
				success:function(data){ //请求成功后处理函数。  
					$.each(data, function(i,d) {
						var rid=d.id;
						$('#searchable-form').multiSelect('select',rid);
				    });
				    $("#sh").val("");
				    comp.showModal("roleModal");
				}
			});
		}
		
		function saveRole(){
			var roleIds="";
		    $("select[name=countries[]] option[selected]").each(function() { if (roleIds != '') { roleIds += ',' } roleIds += $(this).val() }); 
			$.ajax({
				async : false,
				cache:false,
				type: "POST",
				url: "${rc.contextPath}/user/org/opt-add/saveOrgRole.do",
				data:{roleIds:roleIds,orgId:$('#orgId').val()},
				error: function () {
					$.sticky("请求失败，请稍后再试!", {autoclose : 5000, position: "top-right", type: "st-error" });
				},
				success:function(data){ //请求成功后处理函数。  
					comp.hideModal("roleModal");
				}
			});
		}

//------------------------------common function-----------------------------------------------
//初始化弹出窗口值
	    function clearAddValues(){
	    	clearValidateStyle("name");
	    	clearValidateStyle("code");
	    	clearValidateStyle("area");
	    	clearValidateStyle("comments");
	    	$("#name").val("");
	    	$("#code").val("");
	    	$("#comments").val("");
	    	$("#area").val("");
	    	$("#orgType").val("");
	    }
	    function clearEditValues(){
	    	clearValidateStyle("name_");
	   	 	clearValidateStyle("code_");
	   	 	clearValidateStyle("area_");
	    	clearValidateStyle("comments_");
	    	$("#name_").val("");
	    	$("#code_").val("");
	    	$("#comments_").val("");
	    	$("#area_").val("");
	    	$("#orgType_").val("");
	    }
//初始化树
	    function initTree(){
	    	var Nodes;	
			$.ajax({
				async : false,
				cache:false,
				type: "POST",
				dataType : "json",
				url: "${rc.contextPath}/user/org/opt-query/initOrgData.do",
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试!", {autoclose : 5000, position: "top-right", type: "st-error" });
				},
				success:function(data){ //请求成功后处理函数。  
					Nodes = data;   //把后台封装好的简单Json格式赋给treeNodes
				}
			});
			$.fn.zTree.init($("#tree"), setting, Nodes);
	    }

		//校验组织机构名称同级不能重名,调整时验证
		function isExistOrgName(name,pid,id){
			var flag;
			$.ajax({
					async : false,
					cache:false,
					url: "${rc.contextPath}/user/org/isExistByOrgName.do",
					data:{name:name,parent:pid,id:id},
					type: "POST",
					error: function () {
					comp.message("请求失败，请稍后再试!","error");
					},
					success:function(data){ //请求成功后处理函数。  
						flag = data;
					}
				});
				return flag;
		}
		
		//校验样式初始化
		function validateFormat(id,message){
			clearValidateStyle(id);
			$('#'+id).closest('div').addClass("f_error");
			$('#'+id).closest('div').append("<label class='error'>"+message+"</label>");
		}
		//清除校验样式
		function clearValidateStyle(id){
			$('#'+id).closest('div').removeClass("f_error");
			$('#'+id).closest('div').find('label').remove();
			$('#'+id).closest('div').find('br').remove();
		}
		multiselect = {
			init: function(){
				$('#searchable-form').multiSelect({
					selectableHeader : '<input type="text" id="sh" autocomplete="off" placeholder="搜索" style="width:160px"/>',
					selectedHeader	 : '<a href="javascript:void(0)" id="sForm_deselect" class="btn">全部移除</a>'
				});
				$('#sForm_deselect').on('click', function(){
					$('#searchable-form').multiSelect('deselect_all');
					return false;
				});
				$('input#sh').quicksearch('#ms-searchable-form .ms-selectable li');
				$('#searchable-form').multiSelect();
			}
		};
//页面加载初始化
	    $(function(){
	   		initTree();
			multiselect.init();
			initAddValidate();
		});
		
	
	function cleanNameError(){
			$('#name').closest('div').removeClass("f_error");
			$('#name').closest('div').find('label').remove();
			$('#name').closest('div').find('br').remove();
	}
	function cleanCodeError(){
			$('#code').closest('div').removeClass("f_error");
			$('#code').closest('div').find('label').remove();
			$('#code').closest('div').find('br').remove();
	}
//--------------------------------------------------------------------------------
</script>
</body>
</html>
