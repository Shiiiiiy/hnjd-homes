<div class="row-fluid">
        <div class="span12" style="margin-top:-8px;">
            <div class="nextP">
                <div class="span4" style="padding-left:10px;">
                    <div id="dt_gal_info">
                    <#assign hNext=false />
                   <#if page.totalCount==0>
       			 共${page.totalCount}条
	       		<#else>
	       			${(page.currentPageNo-1)*page.pageSize+1} 到
			       	<#if ((page.currentPageNo*page.pageSize)>=page.totalCount)>
			       		${page.totalCount}
			       		<#assign hNext=false />
			       	<#else>
			       		${page.currentPageNo*page.pageSize}
			       		<#assign hNext=true />
			       	</#if>
			       	条&nbsp;&nbsp;共${page.totalCount}条
	       		</#if>
                    	</div>
                </div>
                <div class="span8" style="padding-right:10px;">
                    <div class="dataTables_paginate paging_bootstrap pagetion">
                        <ul>
                            
                            <li>
                            <a class="arrowh1" href="#" title="首页"  onclick="bdpPage('1','pageFormId','${isAjaxForm!''}')"></a>
                            </li>
                            
                            <#if page.currentPageNo==1>
			           		 <li><a class="arrowh21" title="上一页" href="#" ></a></li>
				           	 <#else>
				       			<li ><a class="arrowh2" href="#" title="上一页" onclick="bdpPage('${page.previousPageNo}','pageFormId','${isAjaxForm!''}')"></a></li>
				       		</#if>
                            
                             <li class="pageline"></li>
                            
                            <li style="height: 30px; line-height:30px;">
                           		 第
				            	<input id="${pageTagformId}gotoPageNumber" style="width:20px;height:15px; text-align: center; " value="${page.currentPageNo}"/>
            					<input id="${pageTagformId}gotoPageFormId" type="hidden" value="pageFormId"/>
            					<input id="${pageTagformId}gotoPageTotalPageCount" type="hidden" value="${page.totalPageCount}"/>
			           		 </li>
                            
                            <li class="disabled">
                            <a>共${page.totalPageCount}页</a>
                            </li>
                            <li class="pageline"></li>
                            
                            <#if hNext >
				       			<li ><a class="arrowh3" title="下一页"  href="#" onclick="bdpPage('${page.nextPageNo}','pageFormId','${isAjaxForm!''}')"> </a></li>
				           	<#else>
				           		<li><a class="arrowh31" title="下一页" href="#" > </a></li>
				       		</#if>
                            
                            <li >
                            <a href="#" class="arrowh4" title="尾页" onclick="bdpPage('${page.totalPageCount}','pageFormId','${isAjaxForm!''}')">
                            </a>
                            </li>
                        </ul>
                    </div>
                </div>
             </div>
        </div>
</div>
<div id="pageFormDiv" name="pageFormDiv" style="display:none"></div>
<script >
	var formId="${pageTagformId}";
	var fromAction= $("#"+formId).attr("action");
	var fromHtml= $("#"+formId).html();
	var isAjaxForm = "${isAjaxForm!''}";
	var pageForm =document.createElement("FORM");
	pageForm.method="post";
	pageForm.action=fromAction;
	pageForm.id="pageFormId";
	pageForm.innerHTML=fromHtml;
	
	document.getElementById("pageFormDiv").appendChild(pageForm);
	$(function (){
		$("#" + formId + "gotoPageNumber").keypress(function(event){
			var maxPageNo= $("#" + formId + "gotoPageTotalPageCount").val()*1;
			var toPageNo= $("#" + formId + "gotoPageNumber").val()*1;
			var curKey = event.which; 
			if(curKey == 13){ 
				var patrn=/^[0-9]{1,20}$/; 
				if (!patrn.exec(toPageNo)){
				comp.message("请输入大于0的整数","error");
			} else {
				if(toPageNo < 1){
					comp.message("请输入大于0的整数","error");
					return false;
				}else if(toPageNo > maxPageNo){
					comp.message("请输入小于最大页数的整数","error");
					return false;
				}
				bdpPage(toPageNo,"pageFormId",'isAjaxForm');
				}
			} 
		})
	}); 
</script>

