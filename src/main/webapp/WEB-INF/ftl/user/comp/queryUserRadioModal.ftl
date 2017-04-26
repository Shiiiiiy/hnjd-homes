

<!--人员选择 -->
<div class="modal hide fade" id="_selectUserModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3>人员选择</h3>
	</div>
	<div class="modal-body" id="_selectUserModalBody">
		<div class="row-fluid">
			<div class="span4">
				<ul id="_selectUserOrgTree" class="ztree myztree"></ul>
			</div>
			<div class="span8">
				<div class="row-fluid">
						<div class="span12">
							
							<form  id="_userQuery"  action="${rc.contextPath}/user/user/comp/queryUser.do" method="post">
							<input id="tag" name="tag" type="hidden" value="radio"/>
							<input id="_userQuery_status" name="status" type="hidden" value=""/>
							<select size="1" id="_selectUserType" name="selectUserType" aria-controls="dt_gal"  class="span4">
								<option value="userName">姓名</option>
								<option value="positionName">岗位名称</option>
								<option value="loginName">登录账号</option>
							</select>
							<input id="_selectUserValue" name="selectUserValue" class="span6"  value=""/>
							<input id="_orgId" name="orgId" type="hidden"/>							
							<input type="button" class="btn btn-info" id="_userQueryButton" onclick="_queryUserSubmit()" value="查 询"/>	
							</form>
							
						</div>
				</div>
				<div class="row-fluid">
					<div class="span12" id="_usersTableDiv">
					</div>					
				</div>
				<input id="_userInfo" name="userInfo" type="hidden" value=""/>		
			</div>			
		</div>
	</div>
	
	<div class="modal-footer">
		<a href="###" class="btn " data-dismiss="modal">取消</a>
		<a href="###" class="btn btn-info" data-dismiss="modal" onclick="_getUser()">确定</a>		
	</div>
</div>

<script>
    

	//获取用户
	function _getUser(){

		comp.hideModal("_selectUserModal");
		var user=eval("["+$("#_userInfo").val()+"]");		
		$("#_userName").val(user[0].userName);
		$("#_userId").val(user[0].userId);
	}
	

	
	function _queryUsersByOrgId(event, treeId, treeNode){
		var treeObj = $.fn.zTree.getZTreeObj("_selectUserOrgTree");
		var node = treeObj.getNodes()[0];
		if(treeObj.id!=node.id)//组机构根节点不传递 组织机构id给后台
			$("#_orgId").val(treeNode.id);
		 
		$("#_selectUserValue").val(""); 
		$('#_userQuery').submit();
	}
	
	//打开面板数据初始化
	function _initValues(status){
	
		$('#_selectUserModal').width(710).css("marginLeft","-350px").css("marginTop","-250px");
		$('#_selectUserModalBody').css("max-height","320px");
		$('#_selectUserOrgTree').width(200).height(300).css("margin-top","0px");
		$('#_userQueryButton').css("margin-bottom","9px");
		$("#_userInfo").val("");
		$('#_selectUserValue').val('');
		$("#_orgId").val("");
		$('#_selectUserType option:first').attr('selected',true);
		if(status!=null&&status!='')
			$("#_userQuery_status").val(status);
		//初始化组织机构树
		comp.initTree("_selectUserOrgTree",comp.contextPath()+"/user/comp/getOrgTree.do",null,null,_queryUsersByOrgId);
		
		
		var treeObj = $.fn.zTree.getZTreeObj("_selectUserOrgTree");
		var node = treeObj.getNodes()[0];
		treeObj.selectNode(node);		
		
		
		//用户ajaxform提交设置
		var ajaxFormOptions = {
            type: "POST",
            success: function(data){
          
			    	
			    $('#_usersTableDiv a[rel=popover]').each(function(){
			   	 	$(this).popover({trigger:'hover',html:true});
			    });
			    
			     $('input[name="row_sel"]').each(function(){
		
			        var value=$(this).attr("value");
			        var obj=eval("["+value+"]");
			        var radio=$(this);
					if(obj[0].userId==$("#_userId").val()){		
						 radio.attr("checked",true);
						 $("#_userInfo").val(radio.attr("value"));
					}
					
			    });	
			  
            },            
            error: function(){
                comp.message("用户查询请求失败，请稍后重试。","error");
            },
            beforeSubmit: function(formData, jqForm, options){
            	           	            	
            },
            target: '#_usersTableDiv'
        };
		
		$('#_userQuery').ajaxForm(ajaxFormOptions);		
		
	}
	
	function _queryUserSubmit(){
		if($('#userQuerypageNo').length>0)
			$('#userQuerypageNo').val('1');
		$('#_userQuery').submit();
	}
	
	function _onClickRadio(obj){
		$("#_userInfo").val($(obj).attr("value"));
		
	}
</script>