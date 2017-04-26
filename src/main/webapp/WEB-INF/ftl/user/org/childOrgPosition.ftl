
<div class="row-fluid" id="smpl_tbl">
	<div class="span12">
		<table class="table table-bordered table-striped tablecut" >
			<thead>
				<tr>
					<th width="10%">序号</th>
					<th>上级岗位</th>
					<th>岗位名称</th>
					<th>操作</th>
				</tr>
			</thead>
			<#if list??>
				<#list list as op>
					<tbody>
						<tr>
							<td>${op_index+1}</td>
							<td class="autocut">
								<#if op.parentOrgPosition.position??>
									${op.parentOrgPosition.position.name}
								<#else>
									
								</#if>
							</td>
							<td class="autocut">${op.position.name}</td>
							<td>
								<#if op.parentOrgPosition.position??>
									<a href="#" onclick="editOrgPosition('${op.parentOrgPosition.id}','${op.id}')" title="修改"><i class="icon-pencil"></i></a>
								<#else>
									<a href="#" onclick="editOrgPosition('','${op.id}')" title="修改"><i class="icon-pencil"></i></a>
								</#if>
								<a href="#" onclick="delOrgPosition('${op.id}')" title="删除"><i class="icon-trash"></i></a>
								<a href="#" onclick="upTreeNode('${op.id}')" title="上移"><i class="icon-circle-arrow-up"></i></a>
								<a href="#" onclick="downTreeNode('${op.id}')" title="下移"><i class="icon-circle-arrow-down"></i></a>
								<a href="#" onclick="popMoveWin('${op.id}')" title="调整"><i class="icon-move"></i></a>
							</td>
						</tr>
					</tbody>
				</#list> 
			</#if>
		</table>
	</div>
</div>