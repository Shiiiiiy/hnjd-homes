<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base233.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/login233.css">
    <link rel="shortcut icon" href="${rc.contextPath}/css/images/favicon.ico" type="image/x-icon"/> 
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <title>数字化校园统一管理平台</title>
</head>
<body>

    <div class="login-bg w"></div>
    <div class="foot w"></div>
    <script type="text/javascript">
        $(function () {
        	window.location="${rc.contextPath}/Portal/opt-query/gotoPortal.do";
        	return;
            var bodyHeight = $(window).height();
            $("body").css("height", bodyHeight);
            //输入框效果
            $(".login-input").focus(function () {
                if (this.value == this.defaultValue) {
                    this.value = '';
                    $(this).css({"color":"#666","background-color":"#f2f2f2"});
                }
            });
            $(".login-input").blur(function () {
                if (this.value == '') {
                    this.value = this.defaultValue;
                    $(this).css({ "color": "#ccc", "background-color": "#fff"});
                }
            });
        });
    </script>
</body>
</html>
