<div class="row-fluid">
	<div class="span12">
			<#if isMore=="true">
				<span class="alert alert-warning">
	        		导出的excel文件个数不能大于500个，请重新设置导出excel文件的单页条数来减少导出文件的个数
    		     </span>
			<#else>
				<div id="dt_gal_wrapper" class="dataTables_wrapper form-inline" role="grid">
					<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
						<thead>
							<tr>
								<th >点击下载excel文件</th>
							</tr>
						</thead>
						<tbody>
							<#list 1..maxNumber as n>
								<tr>
									<td ><a href="###" onclick="exportDate('${exportSize}','${n}')">用户列表第${n}页</td>
								</tr>
							</#list>
						</tbody>
					</table>
				</div>
			</#if>
	 </div>
 </div>