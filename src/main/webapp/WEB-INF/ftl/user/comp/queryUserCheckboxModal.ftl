

<!--人员选择 -->
<div class="modal hide fade" id="_selectUserModal">
	<div class="modal-header">
		<button class="close" data-dismiss="modal">×</button>
		<h3>人员选择</h3>
	</div>
	<div class="modal-body" id="selectUserModalBody">
		<div class="row-fluid">
			<div class="span3">
				<ul id="selectUserOrgTree" class="ztree myztree"></ul>
			</div>
			<div class="span6">
				<div class="row-fluid">
						<div class="span12">
							
							<form  id="userQuery"  action="${rc.contextPath}/user/user/comp/queryUser.do" method="post">
							<input id="tag" name="tag" type="hidden" value="checkbox"/>							
							<input id="_userQuery_status" name="status" type="hidden" value=""/>
							<select size="1" id="selectUserType" name="selectUserType" aria-controls="dt_gal"  class="span4">
								<option value="userName">姓名</option>
								<option value="positionName">岗位名称</option>
								<option value="loginName">登录账号</option>
							</select>
							<input id="selectUserValue" name="selectUserValue" class="span6"  value=""/>
							<input id="orgId" name="orgId" type="hidden"/>							
							<input type="button" class="btn btn-info" id="userQueryButton" onclick="_queryUserSubmit()" value="查 询"/>	
							</form>
							
						</div>
				</div>
				<div class="row-fluid">
					<div class="span12" id="usersTableDiv">
					</div>					
				</div>		
			</div>
			<div class="span3">
				<ul id="selectedUser" class="ztree myztree"></ul>
				<a href="###" class="btn btn-info" onclick="javascript:_deleteAllUsers()">全部删除</a>
			</div>
		</div>
	</div>
	
	<div class="modal-footer">
		<a href="###" class="btn " data-dismiss="modal">取消</a>
		<a href="###" class="btn btn-info" data-dismiss="modal" onclick="_getUsers()">确定</a>		
	</div>
</div>


<script>

	
	//从用户购物车删除
	function _userRemove(event, treeId, treeNode) {
	
		$('input[name="row_sel"]').each(function(){
		
	          var value=$(this).attr("value");
	          var obj=eval("["+value+"]");
	          if(obj[0].userId==treeNode.userId){
	          	$(this).attr("checked",false);
	          	$("#checkUserAll").attr("checked",false);
	          }
	    });		
	}
	
	//从table中移除购物车的用户
	function _removeUserFromTable(value){
	
		var obj=eval("["+value+"]");
		var userTree = $.fn.zTree.getZTreeObj("selectedUser");
		var users =userTree.getNodes();
		$(users).each(function(){
			if($(this)[0].userId==obj[0].userId)
				userTree.removeNode($(this)[0]);
		  });
	}
	
	//从table中添加购物车的用户
	function _addUserFromTable(value){
	
		var userTree = $.fn.zTree.getZTreeObj("selectedUser");
		var users =userTree.getNodes();
		var obj=eval("["+value+"]");
		var tag= true;
		$(users).each(function(){
			if($(this)[0].userId==obj[0].userId){
				tag=false;
				return;
				}
			
		  });
		if(tag)
			userTree.addNodes(null,eval("["+value+"]"));
	}
		
	function _checkUserAll(obj) {

             $('input[name="row_sel"]').attr("checked",obj.checked);
             if($("#checkUserAll").attr("checked")!=null)
	             $('input[name="row_sel"]').each(function(){ 
	             	 _addUserFromTable($(this).attr("value"));
	             });
	         else
	             $('input[name="row_sel"]').each(function(){ 
	             	 _removeUserFromTable($(this).attr("value"));
	             });
             
      }
      
      function  _onClickCheckbox(obj){
 			var $subBox = $("input[name='row_sel']");
        	$("#checkUserAll").attr("checked",$subBox.length == $("input[name='row_sel']:checked").length ? true : false);
        	if($(obj).attr("checked")!=null){
       			_addUserFromTable($(obj).attr("value"));
        	}else{
        		_removeUserFromTable($(obj).attr("value"));
        	}
		}
      
	//打开用户列表选择面板
	//function _selectUsers(){
		
	//	initValues();
	//	queryUserSubmit();		
	//	comp.showModal("selectUserModal");
	//}
	//获取用户
	//function getUsers(){

	//	comp.hideModal("_selectUserModal");
	//	$("#_userIds").val(getUserIds());		
		
	//}
	
	function _getUserIds(){
	
		var treeObj = $.fn.zTree.getZTreeObj("selectedUser");
		var userids="";
		var i=0;
		$(treeObj.getNodes()).each(function(){
			if(i>0)
				userids+=",";
			userids+=$(this)[0].userId;						
			i++;			    
		 });		
		
		return userids;
	}
	function _getUserNames(){
	
		var treeObj = $.fn.zTree.getZTreeObj("selectedUser");
		var userids="";
		var i=0;
		$(treeObj.getNodes()).each(function(){
			if(i>0)
				userids+=",";
			userids+=$(this)[0].userName;						
			i++;			    
		 });		
		
		return userids;
	}
	//返回jason对象
	//function _getUsers(){
	
	//	var treeObj = $.fn.zTree.getZTreeObj("selectedUser");
		
	//	return treeObj.getNodes();
	//}
	
	function _queryUsersByOrgId(event, treeId, treeNode){
		var treeObj = $.fn.zTree.getZTreeObj("selectUserOrgTree");
		var node = treeObj.getNodes()[0];
		if(treeObj.id!=node.id)//组机构根节点不传递 组织机构id给后台
			$("#orgId").val(treeNode.id);
		 
		$("#selectUserValue").val(""); 
		$('#userQuery').submit();
	}
	
	//打开面板数据初始化
	function _initValues(ids,status){
	
		$('#_selectUserModal').width(910).css("marginLeft","-450px").css("marginTop","-250px");
		$('#selectUserModalBody').css("max-height","320px");
		$('#selectUserOrgTree').width(200).height(300).css("margin-top","0px");
		$('#selectedUser').width(200).height(300).css("margin-top","0px");
		$('#userQueryButton').css("margin-bottom","9px");
		$('#selectUserValue').val('');
		$('#selectUserType option:first').attr('selected',true);
		$("#orgId").val("");
		
		if(status!=null&&status!='')
			$("#_userQuery_status").val(status);
		//初始化组织机构树
		comp.initTree("selectUserOrgTree",comp.contextPath()+"/user/comp/getOrgTree.do",null,null,_queryUsersByOrgId);
		
		var treeObj = $.fn.zTree.getZTreeObj("selectUserOrgTree");
		var node = treeObj.getNodes()[0];
		treeObj.selectNode(node);		
		
		var userNodes;
			$.ajax({
					async : false,
					cache:false,
					type: 'POST',
					url: comp.contextPath()+"/user/user/comp/getUsersJson.do",
					data:"ids="+ids,
					error: function () {
						/*扩展错误提示 */
						comp.message("\u8BF7\u6C42\u5931\u8D25\uFF0C\u8BF7\u7A0D\u540E\u518D\u8BD5!","error");
					},
					success:function(data){
						userNodes = eval(data); 
					}
				});
		
		var selectedUserSet = {data:{},view:{showLine:false,selectedMulti: false,showIcon: false},
			edit:{removeTitle:"移除",enable:true,showRenameBtn:false,drag:{prev:true,next:true,inner:false}},callback:{onRemove:_userRemove}};
				
		$.fn.zTree.init($("#selectedUser"), selectedUserSet, userNodes);
		
		//用户ajaxform提交设置
		var ajaxFormOptions = {
            type: "POST",
            success: function(data){
            
          
                $('input[name="row_sel"]').each(function(){
		
			          var value=$(this).attr("value");
			          var obj=eval("["+value+"]");
			          var checkbox=$(this);
			         
					var userTree = $.fn.zTree.getZTreeObj("selectedUser");
					var users =userTree.getNodes();
					$(users).each(function(){
						if($(this)[0].userId==obj[0].userId)							
						    checkbox.attr("checked",true);
					 });
			    });	
			    $("#checkUserAll").attr("checked",
			    	$("input[name='row_sel']").length == $("input[name='row_sel']:checked").length
			    	&& $("input[name='row_sel']").length>0? true : false);
			    
			    	
			    $('#usersTableDiv a[rel=popover]').each(function(){
			   	 	$(this).popover({trigger:'hover',html:true});
			    });
			    
			   // .popover({selector:'a[rel=popover]',trigger:'hover',html:true});
			   
            },            
            error: function(){
                comp.message("用户查询请求失败，请稍后重试。","error");
            },
            beforeSubmit: function(formData, jqForm, options){
            	           	            	
            },
            target: '#usersTableDiv'
        };
		
		$('#userQuery').ajaxForm(ajaxFormOptions);		
		
	}
	
	function _queryUserSubmit(){
		if($('#userQuerypageNo').length>0)
			$('#userQuerypageNo').val('1');
		$('#userQuery').submit();
	}
	//删除所有用户
	function _deleteAllUsers(){
	
		$('input[name="row_sel"]').attr("checked",false);
		$("#checkUserAll").attr("checked",false);
		var userTree = $.fn.zTree.getZTreeObj("selectedUser");
		var nodes = userTree.getNodes();
		
		$(nodes).each(function(){
			userTree.removeNode($(this)[0]);
		});

	}
	
</script>