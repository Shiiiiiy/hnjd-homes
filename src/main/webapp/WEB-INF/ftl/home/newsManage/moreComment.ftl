<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/teacher.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/bootstrap.min.css">
    <!--[if lte IE 9]>
    <script src="${rc.contextPath}/js/respond.min.js"></script>
    <script src="${rc.contextPath}/js/html5shiv.js"></script>
    <![endif]-->
</head>
<body>
     <input type="hidden" name="mystat" value="${(mystat)!''}" />
      <#if messageList??>      
              <#list messageList as ame>
                    <#if ame??>
                        <div class="comment-item clearfix">
                        
                            <ul class="clearfix">
                                
                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
                                <li class="con">
                                    <h3><#if !teacherId??><span class="del-comment fr"><a href="javascript:;" class="A" name="${(am.id)!''}" onclick="deleteMessages(this)"><i class="iconfont f16">&#xe606;</i> 删除</a></span></#if>${(ame.mhSender.name)!""}<span class="date ml20"><#if ame.createTime??>${(ame.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
                                    <p>${((ame.mhContent)!"")?html}</p>
                                    <p class="function">
                                    <a href="javascript:void(0);" class="favor"  onclick="zan(this)">(<span name="Zan">${(ame.mhZan)!""}</span>)</a>
                                    <input type="text" name="myid" value="${(ame.id)!''}"  hidden/>
                                    <a href="javascript:void(0);" class="reply"  onclick="showReceive(this)">回复(${(ame.receive?size)!"0"})</a></p>
                                </li>
                            </ul>
                           
                                <div class="publish publish-small"  style="display:none;">
                                    <textarea>文明上网理性发言，请遵守评论服务协议</textarea>
                                    <div class="user-infor clearfix">
                                        <ul class="fr">
                                            <li class="but" onclick="subReceive(this)"><button>回复</button></li>
                                            <input type="text" name="myid" value="${(ame.id)!''}"  hidden/>
                                        </ul>
                                    </div>
                                </div>
                           
                           <#if ame.receive??>
                            <#list ame.receive as ree>
                               <#if ree??>
		                            <ul class="clearfix replay-list">
		                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
		                                <li class="con">
		                                    <h3><#if !teacherId??><span class="del-comment fr"><a href="javascript:;" class="B" name="${(am.id)!''}" onclick="deleteMessages(this)"><i class="iconfont f16">&#xe606;</i> 删除</a></span></#if>${(ree.mhSender.name)!""}<span class="date ml20"><#if ree.createTime??>${(ree.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
		                                    <p>${((ree.mhContent)!"")?html}</p>
		                                    <!--<p class="function"><a href="javascript:;" class="favor">(0)</a><a href="javascript:;" class="reply">回复(2)</a></p>-->
		                                </li>
		                            </ul>
	                           </#if> 
                            </#list>
                         </#if>   
                      </div>
                  </#if>
            </#list>
     </#if>
     <script>
     $(function(){
     	$(".publish textarea").focus(function () {
                if (this.value == this.defaultValue) {
                    this.value = '';
                    $(this).css({ "color": "#666"});
                }
            });
            $(".publish textarea").blur(function () {
                if (this.value == '') {
                    this.value = this.defaultValue;
                    $(this).css({ "color": "#ccc"});
                }
            });
     });
     </script>
 </body>
</html>