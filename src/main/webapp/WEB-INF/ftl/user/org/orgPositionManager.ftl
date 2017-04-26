<html>
<title>组织机构管理</title>
<head>
	<script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.exhide-3.5.min.js"></script>
<script>
//-----------------------编辑区操作-----------------------------------------------------
//-初始化---------------
//树基本属性配置
		var setting = {
			view: {
				selectedMulti: false,
				dblClickExpand: true,
				showLine: false
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
			if(nodes[0].level==0){
				$('#butPosition').hide();
			}else{
				$('#butPosition').show();
			}
			$('#addsubbutton').show();
			$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":nodes[0].id,"orgId":$("#orgId").val()},function(){});
		}
		
		//添加下级岗位
		function addSubPosition(){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
		 	var nodes = treeObj.getSelectedNodes();
		 	if (nodes.length == 0) {
				//$("#fathermenu").html("");
				$.sticky("请选择一个岗位进行操作", {autoclose : 5000, position: "top-right", type: "st-error" });
				return;
			}
			$('#addsubbutton').hide();
			$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-add/nsm/editOrgPosition.do",{"pid":nodes[0].id,"level":nodes[0].level},function(){});
			
		}
		//修改组织机构岗位
		function editOrgPosition(pid,id){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
		 	var nodes = treeObj.getSelectedNodes();
			$('#addsubbutton').hide();
			$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-add/nsm/editOrgPosition.do",{"pid":pid,"id":id,"level":nodes[0].level},function(){});
			
		}
		//添加组织机构岗位维护
		function addOrgPosition(){
			
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getSelectedNodes();
			var pnode = nodes[0];
			
			var positionId=$("#positionId").val();
			var orgId=$("#orgId").val();
			var obj=$("#positionId");
			var parentId =$("#parentId").val();
			var id =$("#id").val();
			
			var node = treeObj.getNodeByParam("id", id, null);
			
			if(positionId==""||positionId==null){
				validateFormat("positionId","岗位名称不能为空");
				return false;
			}
			var name=obj.find("option:selected").text(); 
			
			$.ajax({
				async :false,
				cache :false,
				timeout: 100000,
				url: "${rc.contextPath}/user/org/opt-add/addOrgPosition.do",
				data:{positionId:positionId,orgId:orgId,parentId:parentId,id:id},
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					if(data!="error"){
						if (pnode) {
							if(id!=null && id!=""){
								node.name=name;
								treeObj.updateNode(node);
							}else{
								treeObj.addNodes(pnode, {id:(data), pId:pnode.id,name:(name)});
							}
						} else {
							if(id!=null && id!=""){
								node.name=name;
								treeObj.updateNode(node);
							}else{
								treeObj.addNodes(null, {id:(data), pId:null,name:(name)});
							}
						}
						$('#addsubbutton').show();
						$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":nodes[0].id,"orgId":$("#orgId").val()},function(){});
					}else{
						validateFormat("positionId","同一组织机构下不能存在相同的岗位")
						return ;
					}
				}
			});
		}
		//删除
		function delOrgPosition(id){
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
						url: "${rc.contextPath}/user/org/opt-del/deleteOrgPosition.do?id="+id,
						error: function () {//请求失败处理函数
							$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
							return;
						},
						success:function(data){ //请求成功后处理函数。  
							if("success"==data){
								treeObj.removeNode(node);
								$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":pnode.id,"orgId":$("#orgId").val()},function(){});
							}else{
								$.sticky("该岗位已被人员引用或者存在下级岗位,请先解除引用关系后再删除!", {autoclose : 5000, position: "top-right", type: "st-error" });
							}
						}
					});
				}
			});
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
				url: "${rc.contextPath}/user/org/opt-query/upDownOrgPosition.do?sourceId="+node.id+"&targetId="+preNode.id,
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					treeObj.moveNode(preNode,node,"prev");
					$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":pnode.id,"orgId":$("#orgId").val()},function(){});
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
				url: "${rc.contextPath}/user/org/opt-query/upDownOrgPosition.do?sourceId="+node.id+"&targetId="+preNode.id,
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					treeObj.moveNode(preNode,node,"next");
					$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":pnode.id,"orgId":$("#orgId").val()},function(){});
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
				type: 'POST',
				dataType : "json",
				url: "${rc.contextPath}/user/org/opt-query/initOrgPosition.do",
				data:{orgId:$("#orgId").val()},
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
        function moveOrgPosition(){
            var id=$("#moveCurTreeId").val();
        	var curObj = $.fn.zTree.getZTreeObj("tree");//原对象
        	var targetObj = $.fn.zTree.getZTreeObj("targetTree");//目标对象
        	var targetNodes = targetObj.getSelectedNodes();//目标菜单
        	if(targetNodes==null || targetNodes.length<1){
        		comp.message("请选择目标岗位","error");
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
			
			$.ajax({
				async :false,
				cache :false,
				dataType :"text",
				type:"POST",
				timeout: 100000,
				url: "${rc.contextPath}/user/org/opt-query/moveOrgPosition.do",
				data:{sourceId:curNode.id,targetId:targetNode.id},
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试", {autoclose : 5000, position: "top-right", type: "st-error" });
					return;
				},
				success:function(data){ //请求成功后处理函数。  
					comp.message("调整成功","info");
					curObj.moveNode(targetNode, curNode, "inner");
	        		$('#treeModal').modal('hide');
	        		$("#smpl_tbl").load("${rc.contextPath}/user/org/opt-query/nsm/childOrgPosition.do",{"pid":pnode.id,"orgId":$("#orgId").val()},function(){});
				}
			});
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
		}
		//组织机构选择岗位
		$(function(){
			comp.initTree("orgPosTree","${rc.contextPath}/user/comp/getOrgTree.do",null,null,getPositionTree);
		});
		function getPositionTree(){
			var id=comp.returnTreeValue("orgPosTree","sel")[0].id;
			var originId =$("#orgId").val();
			if (originId == id) {
				$.sticky("请不要选择当前部门", {autoclose : 5000, position: "top-right", type: "st-error" });
				comp.getTreeObj("positionTree").destroy();
			} else {
				comp.initTree("positionTree","${rc.contextPath}/user/comp/getPositionTree.do",{orgId:id},"radio");
			}
		}
		function popposgSelect(orgId,positionId){
			if(positionId!=""){
				var orgTree= $.fn.zTree.getZTreeObj("orgPosTree");
				var orgNode = orgTree.getNodeByParam("id", orgId, null);
				orgTree.selectNode(orgNode);
				getPositionTree();
				var posTree= $.fn.zTree.getZTreeObj("positionTree");
				var posNode = posTree.getNodeByParam("id", positionId, null);
				posTree.checkNode(posNode);
				posTree.expandAll(true);
			}
			
			comp.showModal("positionModal");
		}
		function getPosition(){
			var treeObj = $.fn.zTree.getZTreeObj("orgPosTree");
			if(treeObj.getSelectedNodes().length==0){
				comp.message("请选择一个组织机构","error");
				return;
			}
			if(comp.returnTreeValue("positionTree")==""){
				comp.message("请选择一个岗位","error");
				return;
			}
			var parentName=comp.returnTreeValue("positionTree")[0].name;
			var parentId=comp.returnTreeValue("positionTree")[0].id;
			var name=treeObj.getSelectedNodes()[0].name;
			
			$('#parentOrgName').val(name);
			$('#parentName').val(parentName);
			$('#parentId').val(parentId);
			comp.hideModal("positionModal");
		}
		
//------------------------------common function-----------------------------------------------

//初始化树
	    function initTree(){
	    	var Nodes;	
			$.ajax({
				async : false,
				cache:false,
				type: 'POST',
				dataType : "json",
				url: "${rc.contextPath}/user/org/opt-query/initOrgPosition.do",
				data:{orgId:'${org.id}'},
				error: function () {//请求失败处理函数
					$.sticky("请求失败，请稍后再试!", {autoclose : 5000, position: "top-right", type: "st-error" });
				},
				success:function(data){ //请求成功后处理函数。  
					Nodes = data;   //把后台封装好的简单Json格式赋给treeNodes
				}
			});
			$.fn.zTree.init($("#tree"), setting, Nodes);
	    }
		
//页面加载初始化
	    $(function(){
			initTree();
		});
//--------------------------------------------------------------------------------
</script>
</head>
<body>
<div id="contentwrapper">
    <div class="main_content">
    	<h3 class="heading">${org.name}岗位维护</h3>
		<div class="container-fluid">
			<div class="row-fluid">
				<div class="span3">
					<div class="span12">
						<ul id="tree" class="ztree myztree"></ul>
					</div>
				</div>
				<div class="span9">
					<div class="row-fluid">
						  <button class="btn btn-info" id="addsubbutton" onclick="addSubPosition()">增加下级岗位</button>
					</div>
					<div class="row-fluid">
						 <#include "childOrgPosition.ftl">
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn  btn-info" onclick="getPosition()">确定</a>
	</div>
</div>
<!--调整弹出目标树-->
<div class="modal hide fade" id="treeModal" style="width: 330px;">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3 id="title1">选择目标岗位</h3>
	</div>
	<div class="modal-body">
		<div class="span3">
			<ul id="targetTree" class="ztree"></ul>
		</div>
	</div>
	<div class="modal-footer">
		<a href="#" class="btn" data-dismiss="modal">取消</a>
		<a href="#" class="btn btn-info" onclick="moveOrgPosition()">确认</a>
	</div>
</div>

<input  type="hidden" value="" id="moveCurTreeId"/>
<input  type="hidden" value="${org.id}" id="orgId"/>
</body>
</html>
