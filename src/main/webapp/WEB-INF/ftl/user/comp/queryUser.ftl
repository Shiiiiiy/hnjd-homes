

<table class="table table-bordered table-striped tablecut" id="selectUserTable">
							<thead>
								<tr>
									<th class="table_checkbox" width="2%"><input type="checkbox" name="select_rows" class="select_rows" id="checkUserAll" onclick="checkUserAll(this)"/></th>
									<th  width="25%">姓名</th>
									<th width="20%">登录账号</th>
									<th width="25%">组织机构</th>
									<th width="25%">主岗位</th>
								</tr>
							</thead>
							<tbody>
							<#if page??>
								<#list page.result as user>
									<tr>
									    <td><input type="checkbox" name="row_sel" value="${(user.userInfo)!""}" onclick="onClickCheckbox(this)"/></td>
										<td class="autocut"><a rel="popover" title="${(user.name)!""}" data-content="${user.userDesc?html}">${(user.name)!""}</a></td>
										<td class="autocut">${(user.loginName)!""}</td>
										<td class="autocut">${(user.mainGroupName)!""}</td>
										<td class="autocut">${(user.mainPostionName)!""}</td>
									</tr>
								</#list> 
							</#if>															
							</tbody>
						</table>


<div class="row-fluid">
<div class="span12">
	<div class="span2">
       <div class="dataTables_info" id="dt_gal_info">
       		<#assign hNext=false />
       		<#if page.totalCount==0>
       			
       		<#else>
       			
		       	<#if ((page.currentPageNo*page.pageSize)>=page.totalCount)>
		       		
		       		<#assign hNext=false />
		       	<#else>
		       		
		       		<#assign hNext=true />
		       	</#if>
		       	${page.totalCount}条数据
       		</#if>
       	</div>
    </div>
    <div class="span10">
       <div class="dataTables_paginate paging_bootstrap pagination">
       	 <ul>
       	 	<li class="disabled"><a href="#" >共${page.totalPageCount}页</a></li>
   			<li><a href="#" onclick="bdpPage('1','pageFormId')">&lt;首页</a></li>
   			<#if page.currentPageNo==1>
           		 <li class="prev disabled"><a href="#" >&lt;上一页</a></li>
           	 <#else>
       			<li class="prev"><a href="#" onclick="bdpPage('${page.previousPageNo}','pageFormId')">&lt;上一页</a></li>
       		</#if>
            <li style="float:left;">
            	<input id="gotoPageNumber" style="width:20px;height:15px;" value="${page.currentPageNo}"/>
            	<input id="gotoPageFormId" type="hidden" value="pageFormId"/>
            	<input id="gotoPageTotalPageCount" type="hidden" value="${page.totalPageCount}"/>
            </li>
   			<#if hNext >
       			<li class="next"><a href="#" onclick="bdpPage('${page.nextPageNo}','pageFormId')">下一页 &gt; </a></li>
           	<#else>
           		<li class="next disabled"><a href="#" >下一页 &gt; </a></li>
       		</#if>
   			<li><a href="#" onclick="bdpPage('${page.totalPageCount}','pageFormId')">尾页&gt;</a></li>
          </ul>
          <ul>
      	</div>
     </div>
      </div>
</div>
<div id="pageFormDiv" name="pageFormDiv" style="display:none">
</div>

<script >
$("document").ready(function(){
	var formId="${formId}";
	var fromAction= $("#"+formId).attr("action");

	var pageForm =document.createElement("FORM");
	pageForm.method="post";
	pageForm.action="${rc.contextPath}/user/user/comp/queryUser.do";
	pageForm.id="pageFormId";
	document.getElementById("pageFormDiv").appendChild(pageForm);	

	
	$("#pageFormId").append($("<input name='selectUserType' type='hidden' value='${selectUserType}'/>"));
	$("#pageFormId").append($("<input name='selectUserValue' type='hidden' value='${selectUserValue}'/>"));
	$("#pageFormId").append($("<input name='orgId' type='hidden' value='${orgId}'/>"));
	$("#pageFormDiv").append($("#pageFormId"));

	//用户ajaxform提交设置
		var pageFormOptions = {
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
	$("#pageFormId").ajaxForm(pageFormOptions);	
	
	});
</script>