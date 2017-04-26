
<div class="row-fluid" id="smpl_tbl">
	<div class="span12">
		<table class="table table-bordered table-striped tablecut" >
			<thead>
				<tr>
					<th width="10%">序号</th>
					<th>机构名称</th>
					<th>机构编码</th>
					<th>机构类型</th>
					<#if user_key.optMap['update']?? || user_key.optMap['del']??  || user_key.optMap['rogrole']??>
						<th>操作</th>
					</#if>
				</tr>
			</thead>
			<#if orgList??>
				<#list orgList as org>
					<tbody>
						<tr>
							<td>${org_index+1}</td>
							<td class="autocut">${org.name}</td>
							<td class="autocut">${org.code}</td>
							<td class="autocut"><#if org.orgType??>${org.orgType.name}</#if></td>
							<#if user_key.optMap['update']?? || user_key.optMap['del']??  || user_key.optMap['rogrole']??>
							<td>
								<#if user_key.optMap['update']??>
									<a href="#" onclick="popEditWin('${org.id}')" title="修改"><i class="icon-pencil"></i></a>
								</#if>
								<#if user_key.optMap['del']??>
									<a href="#" onclick="delOrgNode('${org.id}')" title="删除"><i class="icon-trash"></i></a>
								</#if>
								<#if user_key.optMap['update']??>
									<a href="#" onclick="upTreeNode('${org.id}')" title="上移"><i class="icon-circle-arrow-up"></i></a>
									<a href="#" onclick="downTreeNode('${org.id}')" title="下移"><i class="icon-circle-arrow-down"></i></a>
									<a href="#" onclick="popMoveWin('${org.id}')" title="调整"><i class="icon-move"></i></a>
								</#if>
								<#if user_key.optMap['rogrole']??>
									<a href="#" onclick="roleWin('${org.id}')" title="指定角色"><i class="splashy-contact_grey"></i></a>
								</#if>
							</td>
							</#if>
						</tr>
					</tbody>
				</#list> 
			</#if>
		</table>
	</div>
</div>