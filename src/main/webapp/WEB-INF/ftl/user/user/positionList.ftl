<div class="dataTables_wrapper form-inline" role="grid">
	<div class="row">
		<div class="span6">
        	<p class="dt_actions">
        		<#if user_key.optMap['add']??>
				<button class="btn btn-info" type="button" onclick="addPosition()">新 增</button> 
				</#if>
				<!--<button class="btn" type="button" onclick="goToList()">返回列表</button>-->
			</p>
		</div>
	    
	</div>
	<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
		<thead>
			<tr>
				<th width="10%">序号</th>
				<th>组织机构</th>
				<th>岗位名称</th>
				<th>是否主岗位</th>
				<#if user_key.optMap['update']?? || user_key.optMap['del']??>
				<th>操作</th>
				</#if>
			</tr>
		</thead>
		<tbody>
		<#if userPositioList??>
			<#list userPositioList as up>
			<tr>
				<td class="autocut">${up_index+1}</td>
				<td class="autocut"  title="${up.orgNamePath}">${up.org.name}</td>
				<td class="autocut">${up.orgPositon.position.name}(${up.orgPositon.org.name})</td>
				<td class="autocut">${(up.mainPos.name)!""}</td>
				<#if user_key.optMap['update']?? || user_key.optMap['del']??>
				<td >
					<#if user_key.optMap['update']??>
					<a href="#" onclick="editPosition('${up.id}','${up.user.id}')" class="sepV_a" title="修改"><i class="icon-pencil"></i></a>
					</#if>
					<#if user_key.optMap['del']??>
					<a href="#" onclick="delPosition('${up.id}')" title="删除"><i class="icon-trash"></i></a>
					</#if>
				</td>
				</#if>
			</tr>
			</#list> 
		</#if>
		</tbody>
	</table>
</div>