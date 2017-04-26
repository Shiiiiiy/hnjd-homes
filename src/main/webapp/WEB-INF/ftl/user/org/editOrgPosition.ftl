<div class="row-fluid" id="smpl_tbl">
	<#if level=="0">
		<div class="formSep">
			<div class="row-fluid">
				<div class="span8">
					<div class="span3">
						<label >上级组织机构 </label>
					</div>
					<div class="span9">
						<#if parentoOp??>
							<input type="text" value="${parentoOp.org.name}" id="parentOrgName" class="span6"  disabled="disabled"/>
						<#else >
							<input type="text" value="" id="parentOrgName" class="span6"  disabled="disabled"/>
						</#if>
					</div>
				</div>
			</div>
		</div>
		<div class="formSep">
			<div class="row-fluid">
				<div class="span8">
					<div class="span3">
						<label >上级岗位 </label>
					</div>
					<div class="span9">
						<#if parentoOp??>
							<input type="text" id="parentName" value="${parentoOp.position.name}" class="span6" disabled="disabled"/>
							<input type="hidden" id="parentId" value="${parentoOp.id}" class="span6" />
						<#else >
							<input type="text" id="parentName" value="" class="span6" disabled="disabled"/>
							<input type="hidden" id="parentId" value="" class="span6" />
						</#if>
						<#if parentoOp??>
						<!--
							<button class=" btn-info" type="button" onclick="popposgSelect('${parentoOp.org.id}','${parentoOp.id}')">选择上级</button>
							-->
							<a style="cursor:pointer" onclick="popposgSelect('${parentoOp.org.id}','${parentoOp.id}')">选择</a>&nbsp;
						<#else >
						<!--
							<button class=" btn-info" type="button" onclick="popposgSelect('','')">选择上级</button>
							-->
							<a style="cursor:pointer" onclick="popposgSelect('','')">选择</a>&nbsp;
						</#if>
					</div>
				</div>
			</div>
		</div>
	<#else>
		<div class="formSep">
			<div class="row-fluid">
				<div class="span8">
					<div class="span3">
						<label >上级岗位 </label>
					</div>
					<div class="span9">
						<input type="text"  value="${parentoOp.position.name}" disabled="disabled"/>
						<input type="hidden" id="parentId" value="${parentoOp.id}" />
					</div>
				</div>
			</div>
		</div>
	</#if>
	<div class="formSep">
		<div class="row-fluid">
			<div class="span8">
				<div class="span3">
					<label >岗位名称 <span class="f_req">*</span></label>
				</div>
				<div class="span9">
					<select size="1" id="positionId" aria-controls="dt_gal"  >
						<option value="">请选择..</option>
						<#if op??  >
							<#if allPosition??  >
								<#list allPosition as pos>
									<#if op.position.id==pos.id>
										<option value="${pos.id}" selected="selected" >${pos.name}</option>
									<#else>
										<option value="${pos.id}" >${pos.name}</option>
									</#if>
								</#list>
							</#if>
						<#else>
							<#if allPosition??  >
								<#list allPosition as pos>
										<option value="${pos.id}" >${pos.name}</option>
								</#list>
							</#if>
						</#if>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="span6">
    	<p class="btnMargin">
    		<#if  op?? >
    			<input type="hidden" id="id" value="${op.id}" />
    		<#else>
				<input type="hidden" id="id" value="" />
			</#if>
			<button class="btn btn-info" type="button" onclick="addOrgPosition()">确 定</button>
		</p>
	</div>
</div>
