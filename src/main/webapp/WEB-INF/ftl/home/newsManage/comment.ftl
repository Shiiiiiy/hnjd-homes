<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/teacher.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/bootstrap.min.css">
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/bootstrap.min.js"></script>
    <!--[if lte IE 9]>
    <script src="${rc.contextPath}/js/respond.min.js"></script>
    <script src="${rc.contextPath}/js/html5shiv.js"></script>
    <![endif]-->
    <title>评论</title>
</head>
<body>
    <!--header-->
    <div class="header w clearfix">
        <div class="container">
            <div class="pull-left"><img src="${rc.contextPath}/css/images/logo.png" alt="" /></div>
            <div class="pull-right">
                <div id="localtime" class="f14 ml20 white fl hidden-xs"></div>
                <div class="fl dropdown ml30">
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i>${(login_userName)!""} <i class="caret"></i></a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="<#if login_userType?? && login_userType=='STUDENT'>${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do<#elseif  login_userType?? && login_userType=='TEACHER' && login_isSuperUser?? && login_isSuperUser='1'>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do?superuser=true<#else>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do</#if>">主页</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="${rc.contextPath}/logout.do">退出</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container mb50">
        <ol class="breadcrumb mt20">
            <li><a href="<#if login_userType?? && login_userType=='STUDENT'>${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do<#elseif  login_userType?? && login_userType=='TEACHER' && login_isSuperUser?? && login_isSuperUser='1'>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do?superuser=true<#else>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do</#if>">门户首页</a></li>
            <li class="active">我的评论</li>
        </ol>
        <div class="comment-box">
          
             <#if teacherId??>
                <div class="publish">
                    <textarea id="myComment">文明上网理性发言，请遵守评论服务协议</textarea>
                    <div class="user-infor clearfix">
                        <ul>
                            <li class="user fl"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" />${(teacherName)!''}</li>
                            <li class="but fr" onclick="subComment()" ><button>发表评论</button></li>
                            <input type="text" id="teacherId" value="${(teacherId)!''}"  hidden/>
                        </ul>
                    </div>
                </div>
             </#if>   
          
            <div class="comment-con mt20 pr">
                <span class="nums" id="totals">总共${(allCount)!'0'}条</span>
                <ul id="myTab" class="nav nav-tabs">
                    <li class="active" name="alls"><a href="#home" data-toggle="tab">全部评论</a></li>
                    <li name="mys"><a href="#ios"  data-toggle="tab">我的评论</a></li>
                </ul>
                <input type="hidden" id="allCount" value="${(allCount)!''}"/>
                <input type="hidden" id="myCount" value="${(myCount)!''}"/>
                <div id="myTabContent" class="tab-content">
                    <div class="tab-pane fade in active" id="home">
                  <#if allMessageList??>      
                     <#list allMessageList as am>
                      <#if am??>
                        <div class="comment-item clearfix">
                        
                            <ul class="clearfix">
                                
                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
                                <li class="con">
                                    <h3><#if !teacherId??><span class="del-comment fr"><a href="javascript:;" class="A" name="${(am.id)!''}" ><i class="iconfont f16">&#xe606;</i> 删除</a></span></#if>${(am.mhSender.name)!""}<span class="date ml20"><#if am.createTime??>${(am.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
                                    <p>${((am.mhContent)!"")?html}</p>
                                    <p class="function">
                                    <a href="javascript:void(0);" class="favor"  onclick="zan(this)">(<span name="Zan">${(am.mhZan)!""}</span>)</a>
                                    <input type="text" name="myid" value="${(am.id)!''}"  hidden/>
                                    <a href="javascript:void(0);" class="reply"  onclick="showReceive(this)">回复(${(am.receive?size)!"0"})</a></p>
                                </li>
                            </ul>
                           
                                <div class="publish publish-small"  style="display:none;">
                                    <textarea>文明上网理性发言，请遵守评论服务协议</textarea>
                                    <div class="user-infor clearfix">
                                        <ul class="fr">
                                            <li class="but" onclick="subReceive(this)"><button>回复</button></li>
                                            <input type="text" name="myid" value="${(am.id)!''}"  hidden/>
                                        </ul>
                                    </div>
                                </div>
                           
                           <#if am.receive??>
                            <#list am.receive as re>
                               <#if re??>
		                            <ul class="clearfix replay-list">
		                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
		                                <li class="con">
		                                    <h3><#if !teacherId??> <span class="del-comment fr"><a href="javascript:;" class="B" name="${(re.id)!''}" ><i class="iconfont f16">&#xe606;</i> 删除</a></span> </#if>${(re.mhSender.name)!""}<span class="date ml20"><#if re.createTime??>${(re.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
		                                    <p>${((re.mhContent)!"")?html}</p>
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
                         <#if allMessageList?? && allMessageList?size gt 0>
                         <div style="padding:20px;" id="mores">
                         <input type="text" id="pageNo" name="pageNo"  hidden value="${(pageNo)!''}" />
                         <a href="javascript:void(0);" id="getMores" onclick="getMoreMessages()"  style="display:block;background:#f2f2f2;line-height:30px; text-align:center;">加载更多</a>
                         </div>
                         </#if>   
                    </div>
                     
                    <div class="tab-pane fade" id="ios">
                    
                        <div class="comment-item comment-item-my clearfix">
                        <#if myMessageList??>
                          <#list myMessageList as my>
                              <#if my??>
	                            <ul class="clearfix">
	                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
	                                <li class="con">
	                                    <h3>
	                                    <#if  !teacherId?? || my.mhSender.id==login_userId  >
		                                    <span class="del-comment fr">
		                                    <a href="javascript:;" class="A" name="${(my.id)!''}" >
		                                    <i class="iconfont f16">&#xe606;</i> 删除</a></span>
	                                    
	                                    </#if>
	                                    ${(my.mhSender.name)!""}
	                                    <span class="date ml20">
	                                    <#if my.createTime??>${(my.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
	                                    <p>${((my.mhContent)!"")?html}</p>
	                                    <p class="function"><a href="javascript:;" class="favor" onclick="zan(this)">(<span name="Zan">${(my.mhZan)!""}</span>)</a>
	                                    <input type="text" name="myid" value="${(my.id)!''}"  hidden/>
	                                    <a href="javascript:;"   class="reply" onclick="showReceive(this)">回复(${(my.receive?size)!"0"})</a></p>
	                                </li>
	                            </ul>
	                            
	                                <div class="publish publish-small"  name="pbls"  style="display:none;">
	                                    <textarea>文明上网理性发言，请遵守评论服务协议</textarea>
	                                    <div class="user-infor clearfix">
	                                        <ul class="fr">
	                                            <li class="but" onclick="subReceive(this)"><button>回复</button></li>
	                                            <input type="text" name="myid" value="${(my.id)!''}"  hidden/>
	                                        </ul>
	                                    </div>
	                                </div>
	                            
	                           <#if my.receive??>
	                            <#list my.receive as mr>
	                                <#if mr??>
			                            <ul class="clearfix replay-list">
			                                <li class="image"><img src="${rc.contextPath}/css/images/user.jpg" alt="发表评论" /></li>
			                                <li class="con">
			                                    <h3><#if !teacherId?? || mr.mhSender.id==login_userId ><span class="del-comment fr"><a href="javascript:;" class="B" name="${(mr.id)!''}" ><i class="iconfont f16">&#xe606;</i> 删除</a></span></#if>${(mr.mhSender.name)!""}<span class="date ml20"><#if mr.createTime??>${(mr.createTime)?string("yyyy-MM-dd HH:mm:ss")}</#if></span></h3>
			                                    <p>${((mr.mhContent)!"")?html}</p>
			                                    <!--<p class="function"><a href="javascript:;" class="favor">(0)</a><a href="javascript:;" class="reply">回复(2)</a></p>-->
			                                </li>
			                            </ul>
	                                </#if>
	                            </#list>
	                            </#if>
                              </#if>
                          </#list>    
                         </#if>  
                        </div>
                        
                    </div>
                    
                </div>
                    
                </div>
            </div>
        </div>
    <div class="backtop news-icon" style="display:none;"></div>
    
     <!--弹窗-->
    <div class="popup-back" style="display:none;"></div>
    <div id="limitC" class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><B>提示</B></h4>
        <p class="main f16" id="mains">评论与回复的内容不能超过200字符!</p>
        <p class="tr"><button type="button"  class="btn-s confirm-btn" >确定</button></p>
    </div>
    
    <!--弹窗-->
    <div class="popup-back" style="display:none;"></div>
    <div id="limitD" class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><b>提示</b></h4>
        <p class="main f16">确认删除吗？</p>
        <input type="hidden" id="messg" value=""/>
        <p class="tr"><button type="button" class="btn-s cancel-btn">取消</button><button type="button" id="shure" class="btn-s confirm-btn" name="" onclick="deleteMessages(this)">确定</button></p>
    </div>
    
     <script>
        $(function () {
            $("a.del-btn").click(function () {
                $("#limitD").fadeIn();
            });
            $(".btn-s, span.close-x").click(function () {
                $(".popup-back, .popup-content").fadeOut();
            });
            
            $("a.A").click(function () {
                $("#shure").attr("name",$(this).attr("name"));
                $("#messg").val($(this).attr("class"));
                $("#limitD").fadeIn();
            });
            $("a.B").click(function () {
                $("#shure").attr("name",$(this).attr("name"));
                $("#messg").val($(this).attr("class"));
                $("#limitD").fadeIn();
            });
            
        });
    </script>
    
    
    <script type="text/javascript">
        $(function () {
            $('.backtop').click(function () {
                $('body,html').animate({ scrollTop: 0 }, 500);
            });
            $(window).scroll(function () {
                var height = $(window).scrollTop();
                if (height > 200) {
                    $('.backtop').fadeIn();
                } else {
                    $('.backtop').fadeOut();
                };
            });
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
            $(".function a.reply").click(function () {
                $(this).parents(".comment-item").children("form").children(".publish-small").toggle();
            });
            $("ul#myTab li").click(function () {
               if($(this).attr("name")=="alls"){
                    $("#totals").text("总共"+$("#allCount").val()+"条");
               }else if($(this).attr("name")=="mys"){
                    $("#totals").text("总共"+$("#myCount").val()+"条");
               }
            });
        });
    </script>
    <script type="text/javascript">
        function showLocale(objD) {
            var str, colorhead, colorfoot;
            var yy = objD.getYear();
            if (yy < 1900) yy = yy + 1900;
            var MM = objD.getMonth() + 1;
            if (MM < 10) MM = '0' + MM;
            var dd = objD.getDate();
            if (dd < 10) dd = '0' + dd;
            var ww = objD.getDay();
            if (ww == 0) colorhead = "<font color=\"#ffffff\">";
            if (ww > 0 && ww < 6) colorhead = "<font color=\"#ffffff\">";
            if (ww == 6) colorhead = "<font color=\"#ffffff\">";
            if (ww == 0) ww = "星期日";
            if (ww == 1) ww = "星期一";
            if (ww == 2) ww = "星期二";
            if (ww == 3) ww = "星期三";
            if (ww == 4) ww = "星期四";
            if (ww == 5) ww = "星期五";
            if (ww == 6) ww = "星期六";
            colorfoot = "</font>"
            str = colorhead + yy + "年" + MM + "月" + dd + "日" + "  " + ww + colorfoot;
            return (str);
        }
        function tick() {
            var today;
            today = new Date();
            document.getElementById("localtime").innerHTML = showLocale(today);
            window.setTimeout("tick()", 1000);
        }
        tick();
    </script>
    
     <script type="text/javascript">
     
          function zan(obj){
              
              var messageId=$(obj).next().val();
              $.ajax({ 
						type:"post",
						url:"${rc.contextPath}/menhu/opt-update/updateMessageZan.do",
						data:{"messageId":messageId},
						dataType:"text",
						success:function(data){
						     if(data.indexOf("ok")>-1){
						          var str=$(obj).children("span").text();
                                  var zan=parseInt(str)+1;
                                  $(obj).children("span").text(zan);
                                  $(obj).removeAttr("onclick");
						     }
					    } 
		      }); 
          }
          
          function subReceive(obj){
              var messageId=$(obj).next().val();
              var content=$(obj).parent().parent().prev("textarea").val();
              var teacherId=$("#teacherId").val();
              if(teacherId==undefined){
                 teacherId="";
              }
              content=content.replace(/(^\s*)|(\s*$)/g,'');
              if(content.length>200){
                     $("#mains").text("评论与回复的内容不能超过200字符!");
                     $("#limitC").fadeIn();
              }else if(content=="文明上网理性发言，请遵守评论服务协议" || content==null || content==""){
                     $("#mains").text("内容不能为空!");
                     $("#limitC").fadeIn();
              }else{
                     window.location.href="${rc.contextPath}/menhu/opt-add/addMessageReceive.do?messageId="+messageId+"&content="+content+"&teacherId="+teacherId;
              }
          }
          
          function subComment(){
              var teacherId=$("#teacherId").val();
              var content=$("#myComment").val();
              
              content=content.replace(/(^\s*)|(\s*$)/g,'');
              if(content.length>200){
                     $("#mains").text("评论与回复的内容不能超过200字符!");
                     $("#limitC").fadeIn();
              }else if(content=="文明上网理性发言，请遵守评论服务协议" || content==null || content==""){
                     $("#mains").text("内容不能为空!");
                     $("#limitC").fadeIn();
              }else{
                     window.location.href="${rc.contextPath}/menhu/opt-add/addMessageComments.do?teacherId="+teacherId+"&content="+content;
              }
              
          }
          
          function showReceive(obj){
           
            var st=$(obj).parent().parent().parent().next();
            if($(st).is(":visible")){ 
               
               $(st).hide();
			} else{
			   $(st).show();
			}
          }
          
          
          function getMoreMessages(){
                var teacherId=$("#teacherId").val();
                if(teacherId==undefined){
                   teacherId="";
                }
                $.ajax({ 
						type:"post",
						url:"${rc.contextPath}/menhu/opt-query/queryMoreMessagesList.do",
						data:{"teacherId":teacherId,"pageNo":$("#pageNo").val()},
						dataType:"html",
						success:function(data){
						      
						      $("#mores").before(data);
						      var str="ok";
						      $.each($("input[name='mystat']"),function(index,item){
					                 if($(this).val()=="no"){
					                     str="no";
					                 }      
					                 
							  });
							  
						      if(str=="ok"){
						          
						           var pageNo=parseInt($("#pageNo").val())+1;
						           $("#pageNo").val(pageNo);
						           
						      }else if(str=="no"){
						           
						           $("#getMores").text("已加载完");
						           $("#getMores").addClass("hidemouse");
						      }
					    } 
		     }); 
          }
          
         
         function deleteMessages(obj){
                var teacherId=$("#teacherId").val();
                if(teacherId==undefined){
                   teacherId="";
                }
                
                var messageId=$("#shure").attr("name");
                var sta=$("#messg").val();
                window.location.href="${rc.contextPath}/menhu/opt-del/deleteMhMessage.do?teacherId="+teacherId+"&messageId="+messageId+"&sta="+sta;
         } 
          
     </script>
</body>
</html>
