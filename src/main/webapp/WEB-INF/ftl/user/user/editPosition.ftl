
<div class="formSep">
<input id="user.id" name="user.id" type="hidden"   value="${userId}"  />
	<div class="row-fluid">
		<div class="span5">
			<div class="span3">
				<label >组织机构 <span class="f_req">*</span></label>
			</div>
			<div class="span9">
				<#if uop??>
					<@token/>
					<input id="orgName" name="orgName"  value="${uop.org.name}"  disabled="disabled" class="span5"/>
					<input id="orgId" name="orgId" type="hidden" value="${uop.org.id}"  />
					
					<input id="userPositionId" name="userPositionId" type="hidden"   value="${uop.id}"  />
				<#else>
					<input id="orgName" name="orgName"  value=""  disabled="disabled" class="span5"/>
					<input id="orgId" name="orgId" type="hidden" value=""  />
					<input id="userPositionId" name="userPositionId" type="hidden"   value=""  />
				</#if>
				<!--
				<button class=" btn-info" type="button" onclick="selectOrg()">选择</button>
				-->
				<a style="cursor:pointer" onclick="selectOrg()">选择</a>&nbsp;
			</div>
		</div>
	</div>
</div>
<div class="formSep">
	<div class="row-fluid">
		<div class="span5">
			<div class="span3">
				<label >岗位 <span class="f_req">*</span></label>
			</div>
			<div class="span9">
				<#if uop??>
					<input id="positionName" name="positionName" disabled="disabled" value="${uop.orgPositon.position.name}"  class="span5"/>
					<input id="orgPositionOrgId" name="orgPositionOrgId" type="hidden" value="${uop.orgPositon.org.id}"  />
					<input id="orgPositionId" name="orgPositionId" type="hidden" value="${uop.orgPositon.id}"  />
				<#else>
					<input id="positionName" name="positionName"  disabled="disabled" value=""  class="span5"/>
					<input id="orgPositionOrgId" name="orgPositionOrgId" type="hidden" value=""  />
					<input id="orgPositionId" name="orgPositionId" type="hidden" value=""  />
				</#if>
				<!--
				<button class=" btn-info" type="button" onclick="selectPosition()">选择</button>
				-->
				<a style="cursor:pointer" onclick="selectPosition()">选择</a>&nbsp;
			</div>
		</div>
	</div>
</div>
<div class="formSep">
	<div class="row-fluid">
		<div class="span5">
			<div class="span3">
				<label >是否主岗位 <span class="f_req">*</span></label>
			</div>
			<div class="span9">
				<#if uop??>
					<#list isMan as dic>
							<#if dic.id==uop.mainPos.id>
								<input type="radio" value="${dic.id}" id="mainPos" name="mainPos"  checked="checked" />&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
							<#else>
								<input type="radio" value="${dic.id}" id="mainPos" name="mainPos"  />&nbsp;${dic.name}
							</#if>
					</#list> 
				<#else>
					<#list isMan as dic>
							<#if dic_index==0>
								<input type="radio" value="${dic.id}" id="mainPos" name="mainPos"  checked="checked" />&nbsp;${dic.name}&nbsp;&nbsp;&nbsp;
							<#else>
								<input type="radio" value="${dic.id}" id="mainPos" name="mainPos"  />&nbsp;${dic.name}
							</#if>
					</#list> 
				</#if>
			</div>
		</div>
	</div>
</div>
<div class="span6">
	<p class="btnMargin">
		<button class="btn btn-info" type="button" onclick="positionSub()">确 定</button>
		&nbsp;&nbsp;&nbsp;
	  	<button class="btn"  type="button" onclick="positionList()">返回</button>
	</p>
</div>


<script>
function selectPosition(){
		var orgTree= $.fn.zTree.getZTreeObj("orgPosTree");
		var posTree= $.fn.zTree.getZTreeObj("positionTree");
		
		var orgId= $("#orgId").val();
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
//				var pnodes = posTree.getSelectedNodes();
//				for(var i=0;i<pnodes.length;i++){
//					posTree.cancelSelectedNode(pnodes[i]);
//				}
				comp.getTreeObj("positionTree").destroy();
			}
		}
		comp.showModal("positionModal");
	}

$(document).ready(function () {
		var orgPositionOrgId= $("#orgPositionOrgId").val();
		var orgPositionId= $("#orgPositionId").val();
		if(orgPositionId!=""){
			comp.initTree("positionTree","${rc.contextPath}/user/comp/getPositionTree.do",{orgId:orgPositionOrgId},"");
		}
	});
</script>
