<aside id ="asideLeft">
    <a href="javascript:void(0)" class="sidebar_switch on_switch ttip_r" title="隐藏菜单栏">Sidebar switch</a>
    <div class="sidebar">
        <div class="sidebar_inner">
            
            <div id="side_accordion" class="accordion">
            	<#if user_key??>
		            <#if user_key.sidebarMenuTree??>
		            	<#list user_key.sidebarMenuTree as sidebarMenu>
			                <div class="accordion-group">
			                    <div class="accordion-heading">
			                        <a href="#collapseOne${sidebarMenu.id}" data-parent="#side_accordion" data-toggle="collapse" class="accordion-toggle">
			                            <i class="${sidebarMenu.classCode!}"></i> ${sidebarMenu.name}
			                        </a>
			                    </div>
			                    <#if sidebarMenu.id = user_key.sidebarParentId>
			                    <div class="accordion-body collapse in" id="collapseOne${sidebarMenu.id}">
			                    <#else>
			                    <div class="accordion-body collapse" id="collapseOne${sidebarMenu.id}">
			                    </#if>
			                        <div class="accordion-inner">
			                            <ul class="nav nav-list">
			                            	<#list sidebarMenu.childList as childMenu>
			                            		<#if childMenu.id = user_key.sidebarMenuId>
			                                	<li class="active"><a href="${rc.contextPath}/security/menuDispatch.do?menuId=${childMenu.id!}">${childMenu.name}</a></li>
			                                	<#else>
			                                	<li><a href="${rc.contextPath}/security/menuDispatch.do?menuId=${childMenu.id!}">${childMenu.name}</a></li>
			                                	</#if>
			                                </#list>
			                            </ul>
			                        </div>
			                    </div>
			                </div>
		                </#list>
	                </#if>
                </#if>
                
                
            </div>
            
        </div>
    </div>
</aside>
<script src="${rc.contextPath}/js/rod_common.js"></script>