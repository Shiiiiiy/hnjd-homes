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
    <title>新闻详细</title>
</head>
<body>
    <!--header-->
    <div class="header w clearfix">
        <div class="container">
            <div class="pull-left"><img src="${rc.contextPath}/css/images/logo.png" alt="" /></div>
            <div class="pull-right">
                <div id="localtime" class="f14 ml20 white fl hidden-xs"></div>
                <div class="fl dropdown ml30">
                    <a href="javascript:;" class="f14 drop" data-toggle="dropdown"><i class="iconfont  f20 white mr5">&#xe603;</i> ${(login_userName)!""}<i class="caret"></i></a>
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
            <li><a href="${rc.contextPath}/menhu/opt-query/queryNewsList.do">新闻公告</a></li>
            <li class="active">新闻详情</li>
        </ol>
        <div class="content-news">
            <h2 class="tc">${((newsInfo.mhNewsTitle)!"")?html}</h2>
            <p class="tc detail"><span>发布者：${((newsInfo.mhPublisher)!"")?html}</span><span>发布时间：<#if newsInfo??>${(newsInfo.createTime)?string("yyyy-MM-dd")}</#if></span></p>
            <div class="contain-box">
                  ${((newsInfo.mhNewsContent)!"")?html}
            </div>
            <div class="past-list">
                <ul>
                  <#if twoNews??>
                    <#list twoNews as tn >
                            <#if tn?? && tn_index==0 && (tn.mhNewsTitle)?? >
                                  <li><a href="${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId=${(tn.id)!''}&typeId=${(tn.mhNewsType.id)!''}&newStat=${(newStat)!''}"><span>上一条</span>${((tn.mhNewsTitle)!"")?html}</a></li>
                            <#elseif tn?? && tn_index==1 && (tn.mhNewsTitle)?? >
                                  <li><a href="${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId=${(tn.id)!''}&typeId=${(tn.mhNewsType.id)!''}&newStat=${(newStat)!''}"><span>下一条</span>${((tn.mhNewsTitle)!"")?html}</a></li>
                            </#if>
                    </#list>
                  </#if>   
                </ul>
            </div>
        </div>
    </div>
    <div class="backtop news-icon" style="display:none;"></div>
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
    </script>
</body>
</html>
