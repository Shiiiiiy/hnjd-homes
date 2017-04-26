
		<div class="tabbable ">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#user" id="user_tab" data-toggle="tab">基本信息</a></li>
				<li ><a href="#login" id="login_tab" data-toggle="tab" >账号信息</a></li>
				<li><a href="#user_role"  id="user_role_tab" data-toggle="tab">角色信息</a></li>
				<li><a href="#user_group"  id="user_group_tab" data-toggle="tab">用户组信息</a></li>
				<li><a href="#user_position"  id="user_position_tab" data-toggle="tab">岗位信息</a></li>
			</ul>
			<!-- 用户基本信息-->
			<div class="tab-content">
				<div class="tab-pane active" id="user">
					<input name="errorText" id="errorText" type="hidden" value="${errorText!""}"/>
					<input id="id" type="hidden" name="id"  value="${(user.id)!""}">
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3" >
										<label class="control-label">人员名称 </label>
									</div>
									<div class="span9">
										<input id="name" name="name"  value="${(user.name)!""}"   disabled="disabled"/>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >性别</label>
									</div>
									<div class="span9">
										<input id="name" name="name"  value="${(user.genderDic.name)!""}"   disabled="disabled"/>
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span5">
									<div class="span3">
										<label >用户类型 </label>
									</div>
									<div class="span9">
										<#if user.userType??>
											<input value="${(user.userType.name)!""}"   disabled="disabled"/>
										<#else>	
											<input    disabled="disabled"/>
										</#if>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >人员状态</label>
									</div>
									<div class="span9">
										<input id="postcode" name="postcode"  value="${(user.statusDic.name)!""}" disabled="disabled"/>
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
										<#if user.certTypeDic??>
											<input value="${(user.certTypeDic.name)!""}"   disabled="disabled"/>
										<#else>	
											<input    disabled="disabled"/>
										</#if>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >证件号码</label>
									</div>
									<div class="span9">
										<input id="certNum" name="certNum"  value="${(user.certNum)!""}" disabled="disabled" />
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
										<input id="birthday" name="birthday"  value="${(user.birthday)!""}" disabled="disabled"/>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >固定电话</label>
									</div>
									<div class="span9">
										<input id="tel" name="tel"  value="${(user.tel)!""}" disabled="disabled"/>
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
										<input id="phone" name="phone"  value="${(user.phone)!""}" disabled="disabled"/>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >电子邮件</label>
									</div>
									<div class="span9">
										<input id="email" name="email"  value="${(user.email)!""}" disabled="disabled"/>
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
										<input id="address" name="address"  value="${(user.address)!""}" disabled="disabled"/>
									</div>
								</div>
								<div class="span5">
									<div class="span3">
										<label >邮编</label>
									</div>
									<div class="span9">
										<input id="postcode" name="postcode"  value="${(user.postcode)!""}" disabled="disabled"/>
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
										<textarea name="comments" id="comments" cols="80" rows="5" class="span12" disabled="disabled">${(user.comments)!""}</textarea>
									</div>
								</div>
							</div>
						</div>
				</div>
				
				<!-- 账号-->
				<div class="tab-pane" id="login"><@token/>
					<div class="formSep">
						<div class="row-fluid">
							<div class="span5">
								<div class="span3">
									<label >登录名 </label>
								</div>
								<div class="span9">
									<input id="name" name="loginName"  value="${(userLogin.loginName)!""}" disabled="disabled" />
									<input  name="user.id" type="hidden"  value="${(user.id)!""}"  />
									<input  name="id" type="hidden"  value="${(userLogin.id)!""}"  />
								</div>
							</div>
						</div>
					</div>
					<div class="formSep">
						<div class="row-fluid">
							<div class="span5">
								<div class="span3">
									<label >账号状态 </label>
								</div>
								<div class="span9 ">
									<#if userLogin.statusDic??>
										<input value="${userLogin.statusDic.name}"   disabled="disabled"/>
									<#else>
										<input value=""   disabled="disabled"/>
									</#if>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 角色-->
				<div class="tab-pane" id="user_role">
						<input id="userid" name="userid" type="hidden"   value="${(user.id)!""}"  />
						<input id="roleIds" name="roleIds" type="hidden"   value=""  />
						<div class="row-fluid">
							<div class="span12" id="userPositionTab">
							    <div class="dataTables_wrapper form-inline" role="grid">
									<table class="table table-bordered table-striped" id="smpl_tbl">
										<#if userRoleList??>
											<#if roleList??>
												<#list roleList as role>
													<#list userRoleList as ur>
														<#if role.id==ur.role.id>
															<tr>
																<td>${role.name}</td>
															</tr>
														</#if>
													</#list>
												</#list>
											</#if>
										</#if>
									</table>
								</div>
							</div>
						</div>
				</div>
				<!-- 用户组-->
				<div class="tab-pane" id="user_group">
						<div class="row-fluid">
							<div class="span12" id="userGroupTab">
							    <div class="dataTables_wrapper form-inline" role="grid">
									<table class="table table-bordered table-striped" id="smpl_tbl">
										<#if userGroupList??>
											<#if groupList??>
												<#list groupList as group>
													<#list userGroupList as up>
														<#if group.id==up.userGroup.id>
															<tr>
																<td>${group.name}</td>
															</tr>
														</#if>
													</#list>
												</#list>
											</#if>
										</#if>
									</table>
								</div>
							</div>
						</div>
				</div>
				
				<!-- 岗位-->
				<div class="tab-pane" id="user_position">
						<div class="row-fluid">
							<div class="span12" id="userPositionTab">
							    <div class="dataTables_wrapper form-inline" role="grid">
									<table class="table table-bordered table-striped" id="smpl_tbl">
										<thead>
											<tr>
												<th>序号</th>
												<th>组织机构</th>
												<th>岗位名称</th>
												<th>是否主岗位</th>
											</tr>
										</thead>
										<tbody>
										<#if userPositioList??>
											<#list userPositioList as up>
											<tr>
												<td>${up_index+1}</td>
												<td title="${up.orgNamePath}">${up.org.name}</td>
												<td>${up.orgPositon.position.name}(${up.orgPositon.org.name})</td>
												<td>${(up.mainPos.name)!""}</td>
											</tr>
											</#list> 
										</#if>
										</tbody>
									</table>
								</div>
							</div>
						</div>
				</div>
				
			</div>
		</div>
    

