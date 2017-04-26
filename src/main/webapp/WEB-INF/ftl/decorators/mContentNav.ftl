<div id="contentwrapperNav">
	<div class="main_content">
 		<nav>
            <div id="jCrumbs" class="breadCrumb module">
                <ul>
                	<li>
                		<a href="${rc.contextPath}/main.do" title="主页"><i class="icon-home"></i></a>
            		</li>
                	<#if user_key??>
			            <#if user_key.navStrList??>
			            	<#list user_key.navStrList as navStr>
			            		<#if navStr_has_next>
				            	<li>
	                        		${navStr!}
	                    		</li>
	                    		<#else>
	                    		<li>
	                        		${navStr!}
	                    		</li>
	                    		</#if>
                    		</#list>
			            </#if>
		            </#if>
                </ul>
            </div>
        </nav>
	 </div>
</div>