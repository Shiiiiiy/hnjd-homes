<form class="addOrgForm">
<div class="row-fluid">
	<div class="span3">上级组织机构 </div>
	<div class="span5" ><input id="fathermenu" disabled="disabled"  type="text" value=""  ></div>
</div>
<div class="row-fluid">
	<div class="span3">组织机构名称<span class="f_req">*</span></div>
	<div class="span5"><input type="text" value="" onclick="cleanNameError();" id="name" name="name"></div>
</div>
<div class="row-fluid">
	<div class="span3">组织机构编码 <span class="f_req">*</span></div>
	<div class="span5"><input type="text" value="" onclick="cleanCodeError();" id="code" name="code"></div>
</div>
<div class="row-fluid">
	<div class="span3">组织机构类型</div>
	<div class="span5">
		<select id="orgType" name="orgType" aria-controls="dt_gal">
			<option  value="">请选择..</option>
				<#if orgTypeList??>
					<#list orgTypeList as orgType>
						<option  value="${orgType.id}">${orgType.name}</option>
					</#list>
				</#if>
		 </select>
	</div>
</div>
<div class="row-fluid">
	<div class="span3">区域 </div>
	<div class="span5"><input type="text" value="" id="area" name="area"></div>
</div>
<div class="row-fluid">
	<div class="span3">备注</div>
	<div class="span5"><input type="text" value="" id="comments" name="comments"></div>
</div>
<input type="hidden" id="pid" value="">
	<@token/>
</form>
