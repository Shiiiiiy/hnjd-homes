<form class="editMenuForm">
	<div class="formSep">
		<div class="row-fluid">
			<div class="span3">上级组织机构 </div>
			<#if org.parentOrg.parentOrg??>
				<div class="span5"><p ><input disabled="disabled" type="text" value="${org.parentOrg.name}"  ></p></div>
			<#else>
				<div class="span5"><input disabled="disabled" type="text" value=""  ></div>
			</#if>
		</div>
		<div class="row-fluid">
			<div class="span3">组织机构名称<span class="f_req">*</span></div>
			<div class="span5"><input type="text" value="${org.name}" id="name_" name="name_" ></div>
		</div>
		<div class="row-fluid">
			<div class="span3">组织机构编码 <span class="f_req">*</span></div>
			<div class="span5"><input type="text" value="${org.code}" id="code_" name="code_"></div>
		</div>
		<div class="row-fluid">
			<div class="span3">组织机构类型</div>
			<div class="span5">
				<select id="orgType_" name="orgType_" aria-controls="dt_gal">
					<option  value="">请选择..</option>
						<#if orgTypeList??>
							<#if org?? && org.orgType??>
								<#list orgTypeList as orgType>
									<#if orgType.id==org.orgType.id >
										<option  value="${orgType.id}" selected="selected">${orgType.name}</option>
									<#else>
										<option  value="${orgType.id}">${orgType.name}</option>
									</#if>
								</#list>
							<#else>
								<#list orgTypeList as orgType>
									<option  value="${orgType.id}">${orgType.name}</option>
								</#list>
							</#if>
						</#if>
				 </select>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span3">区域 </div>
			<div class="span5"><input type="text" value="${(org.area!"")?html}" id="area_" name="area_"></div>
		</div>
		<div class="row-fluid">
			<div class="span3">备注: </div>
			<div class="span5"><input type="text" value="${(org.comments!"")?html}" id="comments_" name="comments_"></div>
		</div>
		<input type="hidden" value="${org.id}" id="id_" >
		<input type="hidden" value="${org.parentOrg.id}" id="parentid_" >
	</div>
</form>