<#if importFlag?? && page??>
<form  id="comparePageQuery" action="${rc.contextPath}/user/user/opt-import/importData.do" method="post">
	<div class="formSep">
		<div class="row-fluid">
			<span class="formTitle" style="color:red;">注意：以下数据为excel导入时和系统数据重复的记录，所选择的记录在重新导入时将被忽略，未选择的记录将被更新。</span>
			<table class="table table-bordered table-striped tablecut" id="smpl_tbl">
				<thead>
					<tr>
						<th class="table_checkbox" rowspan="2" style="text-align:center;vertical-align:middle;">
						<input type="checkbox" name="select_rows" id="select_rows" class="select_rows" data-tableid="smpl_tbl" onclick="javascript:selectAll();"/>
						</th>
						<th width="45%" colspan="3" style="text-align:center;vertical-align:middle;">系统数据</th>
						<th width="45%" colspan="3" style="text-align:center;vertical-align:middle;">Excel数据</th>
					</tr>
					<tr>
						<th width="15%">登录名</th>
						<th width="15%">名称</th>
						<th width="15%">家庭地址</th>
						<th width="15%">登录名</th>
						<th width="15%">名称</th>
						<th width="15%">家庭地址</th>
					</tr>
				</thead>
				<tbody id="demo_list">
					<#list page.result as p>
						<tr>
							<td style="text-align:center;vertical-align:middle;">
								<input type="checkbox" name="row_sel" id="${(p[0].id)!""}" class="select_row" onclick="javascript:selectSingle('${(p[0].id)!""}');"/>
							</td>
							<td class="autocut">${(p[0].loginName)!""?html}</td>
							<td class="autocut">${(p[0].user.name)!""?html}</td>
							<td class="autocut">${(p[0].user.address)!""?html}</td>
							<td class="autocut">${(p[1].loginName)!""?html}</td>
							<td class="autocut">${(p[1].user.name)!""?html}</td>
							<td class="autocut">${(p[1].user.address)!""?html}</td>
						</tr>
					</#list>
				</tbody>
			</table>
			<div class="row-fluid">
				<div class="span12">
					<div class="span4">
						<div class="dataTables_info" id="dt_gal_info">
							<#assign hNext=false />
							<#if ((page.currentPageNo*page.pageSize)>=page.totalCount)>
								<#assign hNext=false />
							<#else>
								<#assign hNext=true />
							</#if>
						</div>
					</div>
					<div class="span8">
						<div class="dataTables_paginate paging_bootstrap pagination">
							<ul id="inspect_page">
								<li class="disabled">
									<a href="javascript:void(0);" >共${page.totalPageCount}页</a>
								</li>
								<#if page.currentPageNo==1>
									<li class="prev disabled">
										<a href="javascript:void(0);" >&lt;上一页</a>
									</li>
								<#else>
									<li class="prev">
										<a href="javascript:void(0);" onclick="gotoInspectPage('${page.previousPageNo}')">&lt;上一页</a>
									</li>
								</#if>
								<#if hNext >
									<li class="next">
										<a href="javascript:void(0);" onclick="gotoInspectPage('${page.nextPageNo}')">下一页 &gt; </a>
									</li>
								<#else>
									<li class="next disabled">
										<a href="javascript:void(0);" >下一页 &gt; </a>
									</li>
								</#if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="formSep">
		<div class="row-fluid">
			<div class="span6">
				<p class="btnMargin">
					<button class="btn btn-info" type="button" onclick="javascript:submitImport();">
						确定导入
					</button>
				</p>
			</div>
		</div>
	</div>
	<input type="hidden" id="compareId" name="compareId" value="" />
</form>
<script type="text/javascript">
	var compareObj = {};

	function contains(id){
		for(var key in compareObj){
			if(key == id)
				return true;
		}
		return false;
	}
	
	function selectAll() {
		var checked = jQuery("#select_rows").prop("checked");
		jQuery("input[name='row_sel']").each(function() {
			jQuery(this).prop("checked", checked);
			var id = jQuery(this).attr("id");
			if (checked) {
				compareObj[id] = id;
			} else {
				delete compareObj[id];
			}
		});
	}

	function selectSingle(id) {
		var flag = true;
		jQuery("input[name='row_sel']").each(function() {
			if (!jQuery(this).prop("checked")) {
				flag = false;
			}
		});
		jQuery("#select_rows").prop("checked", flag);
		var checked = jQuery("#" + id).prop("checked");
		if (checked) {
			compareObj[id] = id;
		} else {
			delete compareObj[id];
		}
	}
	//用户翻页时全选框是否选中,dataNum为当前页中的记录条数
	function checkAll(dataNum) {
		var str = $("input[name='row_sel']:checked").length;//获取选中状态的个数
		//alert(str+"="+dataNum);
		if(str == dataNum){
			$("#select_rows").prop("checked","checked");
		}else{
			$("#select_rows").prop("checked","");
		}
	}
	
	function submitImport() {
		var array = [];
		for (var key in compareObj) {
			array.push(key);
		}
		jQuery("#compareId").val(array.join());
		comp.confirm("所选择的记录导入时将被忽略，确认导入吗？", function(flag) {
			if (flag)
				jQuery("#comparePageQuery").submit();
		});
	}
	
	function gotoInspectPage(page) {
		jQuery.getJSON("${rc.contextPath}/user/user/opt-query/pageQuery.do",
			{
				"pageNo":page
			},function(data){
				jQuery("#demo_list").empty();
				var result = data.result;
				jQuery.each(result, function(i, item) {
					var flag = contains(item.id);
					var html = "<tr>"
							+"	<td style='text-align:center;vertical-align:middle;'><input type='checkbox' name='row_sel' id='"+item.id+"' class='select_row' onclick='javascript:selectSingle(\""+item.id+"\");' "+(flag?"checked":"")+"/></td>"
							+"	<td class='autocut'>"+(!!item.loginName?item.loginName:'')+"</td>"
							+"	<td class='autocut'>"+(!!item.userName?item.userName:'')+"</td>"
							+"	<td class='autocut'>"+(!!item.address?item.address:'')+"</td>"
							+"	<td class='autocut'>"+(!!item.excelLoginName?item.excelLoginName:'')+"</td>"
							+"	<td class='autocut'>"+(!!item.excelUserName?item.excelUserName:'')+"</td>"
							+"	<td class='autocut'>"+(!!item.excelAddress?item.excelAddress:'')+"</td>"
							+"</tr>";
					jQuery("#demo_list").append(html);
				});
				checkAll(result.length);
				var page = data.page;
				jQuery("#inspect_page").empty();
				var pageHTML = '<li class="disabled">'
							  +' <a href="javascript:void(0);" >共'+page.totalPageCount+'页</a>'
							  +'</li>';
				if(page.currentPageNo == 1)
					pageHTML += '<li class="prev disabled">'
							   +' <a href="javascript:void(0);" >&lt;上一页</a>'
							   +'</li>';
				else
					pageHTML += '<li class="prev">'
							   +'	<a href="javascript:void(0);" onclick="gotoInspectPage(\''+page.previousPageNo+'\')">&lt;上一页</a>'
							   +'</li>';
							
				if((page.currentPageNo*page.pageSize)>=page.totalCount)
					pageHTML += '<li class="next disabled">'
							   +'	<a href="javascript:void(0);" >下一页 &gt; </a>'
							   +'</li>';
				else
					pageHTML += '<li class="next">'
								+'	<a href="javascript:void(0);" onclick="gotoInspectPage(\''+page.nextPageNo+'\')">下一页 &gt; </a>'
								+'</li>';
				jQuery("#inspect_page").append(pageHTML);
				
		});
	}
</script>
<#elseif importFlag?? && !(errorText??)>
	<span style="color:blue;font-size:15px">导入成功</span>
</#if>
