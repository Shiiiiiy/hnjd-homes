<header>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <i style="background: url('${rc.contextPath}/img/${_prefix_}logo.png') no-repeat;width:190px;height:40px;display:inline-block; margin:10px 35px 0 10px; float:left"></i>
                <ul class="nav user_menu pull-right">
                    <li class="hidden-phone hidden-tablet">
                        <div class="nb_boxes clearfix">
                            <a data-toggle="dropdown"  data-backdrop="static"  class="label ttip_b" >
                            <span id="Time"></span> <i class="splashy-calendar_week"></i>
                            
                            </a>
                            <span class="dropdown-date">
	                               <font id="roddate"> 
	                               <script type="text/javascript">  
							        function rodDate(){  
							           var date = new Date();
										this.year = date.getFullYear();
										this.month = date.getMonth() + 1;
										this.date = date.getDate();
										this.hour = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
										this.minute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
										//this.second = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
										var currentTime = this.year + "年" + this.month + "月" + this.date + "日 " + this.hour + ":" + this.minute + " " ;
										roddate.innerHTML=currentTime;  
							            setTimeout("rodDate()",1000);  
							        }  
						        rodDate("rodDate()",1000);  
						      </script>
	                               </font>
	                        </span>
                        </div>
                    </li>
                    <li class="divider-vertical hidden-phone hidden-tablet"></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><#if user_key??>${user_key.userName!}</#if> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                        <#if user_key??>
                        <#if user_key.isSuperUser??>
	                    <#if !user_key.isSuperUser>
                        <li><a href="javascript:showProfile()">个人信息</a></li>
                        </#if>
                        </#if>
                        </#if>
                        <li><a href="javascript:changePassword()">修改密码</a></li>
                        <li class="divider"></li>
                        <li><a href="${rc.contextPath}/logout.do">注销</a></li>
                        </ul>
                    </li>
                </ul>
				<a data-target=".nav-collapse" data-toggle="collapse" class="btn_menu">
					<span class="icon-align-justify icon-white"></span>
				</a>
                <nav>
                    <div class="nav-collapse">
                        <ul class="nav">
                        	<#if user_key??>
	                        	<#if user_key.menuTree??>
	                        		<#if user_key.menuTree?size gt 5>
	                        			<!--菜单数量大于5-->
	                        			<#list user_key.menuTree as menu>
		                        		<#if menu_index lt 4>
						                        	<#if menu.id==user_key.headerMenuId>
				                        					<li id="checkStyle${menu.id}" class="chstyle" >
			                                					<a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a>
			                            					</li>
			                            		     <#else>
						                            	<li id="checkStyle${menu.id}" >
						                                <a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a>
						                            	</li>
						                              </#if>
			                            </#if>
			                            </#list>
			                            <#if user_key.menuTree?size gt 3>
			                            <li class="dropdown">
	                                        <a data-toggle="dropdown" class="dropdown-toggle" href="#"><i class="icon-th icon-white"></i> 更多功能<b class="caret"></b></a>
	                                        <ul class="dropdown-menu-y">
	                                        	<#list user_key.menuTree as menu>
			                        				<#if menu_index gt 3>
	                                            		<#if menu.id==user_key.headerMenuId>
				                        					<li id="checkStyle${menu.id}" class="chstyle" >
	                                            			<a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a></li> 
	                                            		<#else>
							                            	<li id="checkStyle${menu.id}" >
							                                <a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a>
							                            	</li>
						                            	</#if>
	                                            	</#if>
			                            		</#list>
	                                        </ul>
	                                    </li>
			                            </#if>
	                        		<#else>
	                        			<!--菜单数量小于5-->
	                        			<#list user_key.menuTree as menu>
				                        	<#if menu.id==user_key.headerMenuId>
					                        	<li id="checkStyle${menu.id}" class="chstyle" >
					                                <a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a>
					                            </li>
				                            <#else>
				                            	<li id="checkStyle${menu.id}" >
				                                <a href="#" onclick="loadSidebar('${menu.id}');"><i class="${menu.classCode!}"></i> ${menu.name}</a>
				                            	</li>
				                            </#if>
		                            	</#list>
	                        		</#if>
	                            </#if>
                            </#if>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
    </div>
    <div class="modal hide fade" id="myMail">
        <div class="modal-header">
            <button class="close" data-dismiss="modal">×</button>
            <h3>New messages</h3>
        </div>
        <div class="modal-body">
            <div class="alert alert-info">In this table jquery plugin turns a table row into a clickable link.</div>
            <table class="table table-condensed table-striped" data-rowlink="a">
                <thead>
                    <tr>
                        <th>发件人</th>
                        <th>Subject</th>
                        <th>日期</th>
                        <th>大小</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>我</td>
                        <td><a href="javascript:void(0)">测试下中文吧</a></td>
                        <td>23/05/2012</td>
                        <td>25KB</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <a href="javascript:void(0)" class="btn">Go to mailbox</a>
        </div>
    </div>
    <div class="modal hide fade" id="myTasks">
        <div class="modal-header">
            <button class="close" data-dismiss="modal">×</button>
            <h3>New Tasks</h3>
        </div>
        <div class="modal-body">
            <div class="alert alert-info">In this table jquery plugin turns a table row into a clickable link.</div>
            <table class="table table-condensed table-striped" data-rowlink="a">
                <thead>
                    <tr>
                        <th>id</th>
                        <th>Summary</th>
                        <th>Updated</th>
                        <th>Priority</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>P-23</td>
                        <td><a href="javascript:void(0)">Admin should not break if URL&hellip;</a></td>
                        <td>23/05/2012</td>
                        <td class="tac"><span class="label label-important">High</span></td>
                        <td>Open</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <a href="javascript:void(0)" class="btn">Go to task manager</a>
        </div>
    </div>
    
    <#-- 修改密码弹出框 begin-->
	  <div class="modal hide fade" id="changepasswordbox">
		<div class="modal-header">
			<button class="close" data-dismiss="modal">×</button>
			<h3 id="title1">修改密码</h3>
		</div>
		<div class="modal-body">
			<#include "/user/user/changePassword.ftl">
		</div>
		<div class="modal-footer">
			<a href="#" class="btn btn" data-dismiss="modal">取消</a>
			<a href="#" class="btn btn-info" onclick="changePasswordSubmit()">确定</a>
		</div>
	</div>
	<#-- 修改密码弹出框 end-->
	<#-- 修改个人信息 begin-->
	<div class="modal hide fade" id="userProfileDiv">
		
	</div>
	<#-- 修改个人信息 end-->
    <script>
    $("document").ready(function(){
    	//$("#systemNameSpan").load("${rc.contextPath}/sys/sysConfig/noSecurity/systemName.do",function(){
    	//});
    	var Time=' 星期'+'日一二三四五六'.charAt(new Date().getDay())
		$("#Time").html(Time);
	
    });
    	jQuery.validator.addMethod("uwsUnEqualTo", function(value, element, param) {
			var target = $(param);
			//if (this.settings.onfocusout) {
			//	target.unbind(".validate-equalTo").bind("blur.validate-equalTo", function() {
			//		$(element).valid();
			//	});
			//}
			return value != target.val();
		}, "新密码不能与旧密码一致");  
		
		jQuery.validator.addMethod("uwsEqualTo", function(value, element, param) {
			var target = $(param);
			return value == target.val();
		}, "新密码不能与旧密码一致");  
			
    	function loadSidebar(menuId){
    		$("#asideLeft").load("${rc.contextPath}/security/loadSidebar.do",{"menuId":menuId},function(){
    		var styleid= "checkStyle"+menuId;
    		var styleArray = $("[id^='checkStyle']");
    		for(var i=0;i<styleArray.length;i++){
    			var obj= styleArray[i];
    			$("#"+obj.id+"").removeClass();
    		}
    		$("#"+styleid+"").attr("class","chstyle");
    		loadOutline(menuId);
    		});
    	}
    	function loadOutline(menuId){
    		$("#outline").load("${rc.contextPath}/security/loadOutLine.do",{"menuId":menuId},function(){});
    	}
    	
    	var form_validation_changepassword = $('.form_validation_changepassword').validate({
				onkeyup: false,
				errorClass: 'error',
				validClass: 'valid',
				focusCleanup:true,
				rules:{
						oldpassword:{required:true,rangelength:[8,16]},
						newpassword:{required:true,rangelength:[8,16],uwsUnEqualTo:'#old_password'},
						verifypassword:{required:true,uwsEqualTo:'#new_password',rangelength:[8,16]}
					},
				highlight: function(element) {
					$(element).closest('div').addClass("f_error");
				},
				unhighlight: function(element) {
					$(element).closest('div').removeClass("f_error");
				},
                errorPlacement: function(error, element) {
                    $(element).closest('div').append(error);
                }
	        });

    	
    	function changePasswordSubmit(){
    		var checkResult = form_validation_changepassword.form();
	        if(checkResult) submitPassword();
    	}
    	
    	//提交修改密码信息
    	function submitPassword(){
    		var oldp = $("#old_password").val();
    		var newp = $("#new_password").val();
    		var verifyp = $("#verify_password").val();
    		$.post(
    			"${rc.contextPath}/user/user/changePassword.do",
    			{
    				oldpassword:oldp,
    				newpassword:newp,
    				verifypassword:verifyp
    			},
    			function(data){
    				if(data=='success'){
    					comp.hideModal('changepasswordbox');
    					$.sticky("密码修改成功！", {autoclose : 5000, position: "top-right", type: "st-info" });
    				}else if(data=='password_null'){
    					$.sticky("密码不能为空！", {autoclose : 5000, position: "top-right", type: "st-error" });
    				}else if(data=='new_verify_uequal'){
    					$.sticky("新密码与确认密码不一致！", {autoclose : 5000, position: "top-right", type: "st-error" });
    				}else if(data=='password_error'){
    					$.sticky("用户密码不正确！", {autoclose : 5000, position: "top-right", type: "st-error" });
    					$("#old_password").val("");
    					//$("#old_password:focus");
    					document.getElementById("old_password").focus();
    				}else if(data=='update_error'){
    					$.sticky("修改用户密码失败！", {autoclose : 5000, position: "top-right", type: "st-error" });
    				}
    				
    			},
    			"text");
    	}
    	
    	<#-- 修改密码 -->
    	function changePassword(){
	    	$("#userProfileDiv").load("${rc.contextPath}/user/user/nsm/changePassword.do");
			comp.showModal('changepasswordbox');
	 	}
	 	function showProfile(){
	 		$.ajax({
				url:"${rc.contextPath}/user/user/nsm/getUserProfileUUID.do",
				async:false,
				cache: false,
				type: "POST",
				data:{},
				success: function(msg){
			    	$("#userProfileDiv").load("${rc.contextPath}/user/user/nsm/loadUserProfile.do?" + msg,function(){
    				});
    				comp.showModal("userProfileDiv");
			   }
			});
    		
	 	}
    </script>
</header>