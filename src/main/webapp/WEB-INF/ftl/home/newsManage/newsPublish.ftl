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
    <title>新闻发布</title>
</head>
<body>
    <!--header-->
    <div class="header w clearfix">
        <div class="container">
            <div class="pull-left"><img src="${rc.contextPath}/css/images/logo.png" alt="" /></div>
            <div class="pull-right">
                <div id="localtime" class="f14 ml20 white fl hidden-xs"></div>
                <div class="fl dropdown ml30">
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i> ${(login_userName)!""} <i class="caret"></i></a>
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
            <li><a href="${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do">门户首页</a></li>
            <li class="active">新闻发布</li>
        </ol>
        <div class="publish-news">
        
            <div id="success" class="alert alert-success alert-dismissable" style="display:none;">
                <button type="button" class="close" data-dismiss="alert"
                        aria-hidden="true">
                    &times;
                </button>
                成功！很好地完成了提交。
            </div>
            
            <div id="error" class="alert alert-danger alert-dismissable" style="display:none;">
                <button type="button" class="close" data-dismiss="alert"
                        aria-hidden="true">
                    &times;
                </button>
                错误！请进行一些更改。
            </div>
            
            <form id="publishing"  method="post" action="${rc.contextPath}/menhu/opt-save/saveNews.do">
                <table class="publish-table" >
                    <tbody>
                        <input type="hidden" id="mhNewsId" name="id"  value="${(mhNews.id)!''}" />
                        <tr style="height:50px;">
                            <td class="txt">新闻标题<span style="color:red;">*</span></td>
                            <td colspan="5"><input type="text" id="mhNewsTitle" value="${((mhNews.mhNewsTitle)!'')?html}" name="mhNewsTitle" class="publish-input" style="width:25%;" /></td>
                        </tr>
                        <tr style="height:50px;">
                            <td class="txt">新闻类别<span style="color:red;">*</span></td>
                            <td colspan="5">
                                <select class="publish-select" id="mhNewsType" name="mhNewsType.id">
                                    <#list newsTypeList as ntt>
                                        <#if mhNews?? && mhNews.mhNewsType?? && mhNews.mhNewsType.id?? && mhNews.mhNewsType.id==ntt.id >
                                           <option selected value="${(ntt.id)!''}">${(ntt.mhName)!''}</option>
                                        <#else>
                                           <option value="${(ntt.id)!''}">${(ntt.mhName)!''}</option>
                                        </#if>   
                                    </#list>
                                   
                                </select>
                            </td>
                        </tr>
                        <tr style="height:50px;">
                            <td class="txt">发布者<span style="color:red;">*</span></td>
                            <td><input type="text" id="mhPublisher" class="publish-input" value="${((mhNews.mhPublisher)!'')?html}" name="mhPublisher" style="width:25%;" value=""/></td>
                        </tr>
                        <tr style="height:50px;">
                            <td colspan="6" class="txt">内容编辑<span style="color:red;">*</span>
                            <div style="margin-top:10px;margin-bottom:10px;">
                                   <textarea cols="20" id="mhNewsContent" rows="6" name="mhNewsContent"  style="width:100%;">${((mhNews.mhNewsContent)!"")?html}</textarea>
							        <br><font size="1" color="grey" style="vertical-align:bottom; padding-bottom:10px"></font>
                            </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <button class="publish-but" onclick="saveNews()">保存</button>
            <button class="publish-but" onclick="publishNews()">发布</button>
            <button class="publish-but" onclick="backtoNews()">取消</button>
        </div>
        </div>
    <div class="backtop news-icon" style="display:none;"></div>
    
     <!--弹窗-->
    <div class="popup-back" style="display:none;"></div>
    <div class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><B>提示</B></h4>
        <p class="main f16" id="mains">评论与回复的内容不能超过200字符!</p>
        <p class="tr"><button type="button"  class="btn-s confirm-btn" >确定</button></p>
    </div>
    
     <script>
        $(function () {
            $("a.del-btn").click(function () {
                $("div.popup-back, div.popup-content").fadeIn();
            });
            $(".btn-s, span.close-x").click(function () {
                $(".popup-back, .popup-content").fadeOut();
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
        function backtoNews(){
      		 window.location="${rc.contextPath}/menhu/opt-query/queryNewsList.do?flag=1";
        }
        
        function publishNews(){
              var mhNewsTitle=$("#mhNewsTitle").val();
              var mhPublisher=$("#mhPublisher").val();
              var mhNewsContent=$("#mhNewsContent").val();
              
              mhNewsTitle=mhNewsTitle.replace(/(^\s*)|(\s*$)/g,'');
              mhPublisher=mhPublisher.replace(/(^\s*)|(\s*$)/g,'');
              mhNewsContent=mhNewsContent.replace(/(^\s*)|(\s*$)/g,'');
            
              
              
              if(mhNewsTitle.length>30){
                     $("#mains").text("新闻标题不能超过30字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsTitle=="文明上网理性发言，请遵守评论服务协议" || mhNewsTitle==null || mhNewsTitle==""){
                     $("#mains").text("新闻标题不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhPublisher.length>20){
                     $("#mains").text("发布者名称不能超过20字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhPublisher=="文明上网理性发言，请遵守评论服务协议" || mhPublisher==null || mhPublisher==""){
                     $("#mains").text("发布者不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsContent.length>3000){
                     $("#mains").text("新闻内容不能超过3000字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsContent=="文明上网理性发言，请遵守评论服务协议" || mhNewsContent==null || mhNewsContent==""){
                     $("#mains").text("新闻内容不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }
              
        
        	 $("#publishing").submit();
        	 
        }
        
        
        function saveNews(){
              var mhNewsTitle=$("#mhNewsTitle").val();
              var mhPublisher=$("#mhPublisher").val();
              var mhNewsContent=$("#mhNewsContent").val();
              
              mhNewsTitle=mhNewsTitle.replace(/(^\s*)|(\s*$)/g,'');
              mhPublisher=mhPublisher.replace(/(^\s*)|(\s*$)/g,'');
              mhNewsContent=mhNewsContent.replace(/(^\s*)|(\s*$)/g,'');
              
              
              if(mhNewsTitle.length>30){
                     $("#mains").text("新闻标题不能超过30字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsTitle=="文明上网理性发言，请遵守评论服务协议" || mhNewsTitle==null || mhNewsTitle==""){
                     $("#mains").text("新闻标题不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhPublisher.length>20){
                     $("#mains").text("发布者名称不能超过20字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhPublisher=="文明上网理性发言，请遵守评论服务协议" || mhPublisher==null || mhPublisher==""){
                     $("#mains").text("发布者不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsContent.length>3000){
                     $("#mains").text("新闻内容不能超过3000字符!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }else if(mhNewsContent=="文明上网理性发言，请遵守评论服务协议" || mhNewsContent==null || mhNewsContent==""){
                     $("#mains").text("新闻内容不能为空!");
                     $("div.popup-back, div.popup-content").fadeIn();
                     return;
              }
              
             $("#publishing").attr("action","${rc.contextPath}/menhu/opt-save/saveNews.do?sts=saves");
        	 $("#publishing").submit();
        	 
        }
    </script>
</body>
</html>
