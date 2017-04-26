<div id="warpper">
    	<#list user_key.menuTree as menu>
        	<#if menu.id==user_key.headerMenuId>
        	<#if menu.menuPic??>
        	<div class="ctn_left_nopic">
    			<img src="${rc.contextPath}/sys/sysConfig/file.do?id=${(menu.menuPic!)?html}" height="405" width="335">
    	 	</div>
    	 	<#else>
    	 		<div class="ctn_left"></div>
    	 	</#if>
    	 	</#if>
         </#list>
    	
        
        <div class="ctn_right">
        	
        	<#list user_key.menuTree as menu>
        	<#if menu.id==user_key.headerMenuId>
        	<h1>${menu.name}</h1>
        	<div class="comm" title="${(menu.comments!)?html}">
        	<#if menu.comments??>
	        <#if menu.comments?length gt 35>
	            ${(menu.comments?substring(0,35))?html}...
	            <#else>
	            ${(menu.comments!)?html}
            </#if>
            </#if>
            </div>
            </#if>
            </#list>
            
	 <#if user_key??>
            <ul>
            <#if user_key.sidebarMenuTree??>
		 		<#list user_key.sidebarMenuTree as sidebarMenu>
		 			<#if sidebarMenu_index lt 5>
		            	<li class="dot_${(sidebarMenu_index+1)%5}" title="${(sidebarMenu.comments!)?html}">
		            	${(sidebarMenu.name!)?html}：
		            	<#if sidebarMenu.comments??>
		            	<#assign commentMaxSize = 22 - sidebarMenu.name?length>
		            	<#if sidebarMenu.comments?length gt commentMaxSize>
		            	${(sidebarMenu.comments?substring(0,commentMaxSize))?html}...
		            	<#else>
			            ${(sidebarMenu.comments!)?html}
			            </#if>
			            </#if>
		            	</li>
		            </#if>
            	</#list>
				</#if>
            </ul>
        
  </#if>
        </div>
    </div>
    </div>
       