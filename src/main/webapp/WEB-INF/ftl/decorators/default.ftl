[#ftl]
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${_sys_title}</title>
    <!-- Bootstrap framework -->
    <link rel="stylesheet" href="${rc.contextPath}/bootstrap/css/bootstrap.min.css" />
    <link rel="shortcut icon" href="${rc.contextPath}/css/images/favicon.ico" type="image/x-icon"/> 
    <!-- <link rel="stylesheet" href="${rc.contextPath}/bootstrap/css/bootstrap-responsive.min.css" /> -->
    <!-- main styles -->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/css/style.css" /> -->
    <!-- rod blue theme-->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/css/blue.css" /> -->
    <!-- breadcrumbs-->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/lib/jBreadcrumbs/css/BreadCrumb.css" /> -->
    <!-- tooltips-->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/lib/qtip2/jquery.qtip.min.css" />  -->
    <!-- code prettify -->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/lib/google-code-prettify/prettify.css" />  -->
    <!-- notifications -->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/lib/sticky/sticky.css" />  -->
    <!-- splashy icons -->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/img/splashy/splashy.css" /> -->
    <!--comp,tree-->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/lib/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"> -->
    <!-- <link rel="stylesheet" href="${rc.contextPath}/css/bdp_comp.css" type="text/css"> -->

    <!--[if lte IE 8]>
    <!--<link rel="stylesheet" href="${rc.contextPath}/css/ie.css" /> -->
    <!--<![endif]-->

    <!--[if lt IE 9]>
    <!--<script src="${rc.contextPath}/lib/html5shiv/html5.js"></script>  -->
    <!-- <script src="${rc.contextPath}/lib/flot/excanvas.min.js"></script>  -->
    <!--<![endif]-->
    <!-- <script>
        //* hide all elements & show preloader
        document.getElementsByTagName('html')[0].className = 'js';
    <!-- </script> -->
    <!--  <script src="${rc.contextPath}/js/jquery.min.js"></script>
    <!-- smart resize event -->
    <!-- <script src="${rc.contextPath}/js/jquery.debouncedresize.min.js"></script>
    <!-- js cookie plugin -->
    <!-- <script src="${rc.contextPath}/js/jquery.cookie.min.js"></script>
    <!-- main bootstrap js -->
    <!-- <script src="${rc.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <!-- code prettifier -->
    <!-- <script src="${rc.contextPath}/lib/google-code-prettify/prettify.min.js"></script>
    <!-- tooltips -->
    <!-- <script src="${rc.contextPath}/lib/qtip2/jquery.qtip.min.js"></script>
    <!-- jBreadcrumbs -->
    <!-- <script src="${rc.contextPath}/lib/jBreadcrumbs/js/jquery.jBreadCrumb.1.1.min.js"></script>
    <!-- common functions -->

    <!--page -->
    <!-- <script src="${rc.contextPath}/js/page.js"></script>
    <!--tree-->
    <!-- <script type="text/javascript" src="${rc.contextPath}/lib/ztree/js/jquery.ztree.all-3.5.min.js"></script>
    <!-- comp -->
    <!-- <script type="text/javascript" src="${rc.contextPath}/js/bdp_comp.js"></script> -->
    <!-- jquery.validate -->
    <!-- <script src="${rc.contextPath}/lib/validation/jquery.validate.min.js"></script>
    <!-- myjs_message_cn -->
    <!--<script src="${rc.contextPath}/lib/validation/localization/messages_cn.js"></script>-->
    <!-- <script src="${rc.contextPath}/js/myjs_message_cn.js"></script>
    <!-- jquery.metadata -->
    <!-- <script src="${rc.contextPath}/js/jquery.metadata.js"></script>
    <!-- sticky messages -->
    <!-- <script src="${rc.contextPath}/lib/sticky/sticky.min.js"></script> -->
    <!-- <script src="${rc.contextPath}/lib/bootbox4/bootbox_custom.js"></script>  -->
    <sitemesh:write property="head"/>
</head>
<body id="maincontainer233" class="clearfix233">
	<!-- header -->
	[#include "empty.ftl"]
	<!-- main content -->
	<!-- <span id="outline"> -->
	<!-- [#include "mContentNav.ftl"] -->
	<!-- </span>  -->
	<sitemesh:write property="body"/>
	[#include "empty.ftl"]
	<!-- sidebar -->
	[#include "empty.ftl"]
</body>



