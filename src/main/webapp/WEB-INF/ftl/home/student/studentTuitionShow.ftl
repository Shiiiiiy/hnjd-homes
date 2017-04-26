<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/content.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/base.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/iconfont.css">
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/bootstrap.min.css">
    <script type="text/javascript" src="${rc.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${rc.contextPath}/js/Chart.js"></script>
    <!--[if lte IE 9]>
    <script src="${rc.contextPath}/js/respond.min.js"></script>
    <script src="${rc.contextPath}/js/html5shiv.js"></script>
    <![endif]-->
    <title>缴费信息</title>
</head>
<body>
<h1 class="title">缴费信息</h1>
<div class="container-body">
    <div class="mt20 line-view">
        <#if TuitionList??>
            <#list TuitionList as tt>
                <div class="classify-box">
                    <h3><span class="fr ss fn"><i style="font-style:normal;">收缩详情</i><b class="up"></b></span>${(tt.year)!""}年<b class="orange-stu"> ${(tt.result)!""}</b></h3>
                    <div class="line-box">
                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-lg-offset-1 hidden-xs hidden-sm">
                            	<#if (tt.result)?? && tt.result=="已缴清">
               	                    <div class="nodata tc mt30">
		                                <img src="${rc.contextPath}/css/images/no1.png" alt="${(tt.result)!""}" />
		                                <p style="color:green;">${(tt.result)!""}</p>
		                            </div>
		                            <#elseif tt.result=="未缴费">
		                            <div class="nodata tc mt30">
		                                <img src="${rc.contextPath}/css/images/no.png" alt="${(tt.result)!""}" />
		                                <p>${(tt.result)!""}</p>
		                            </div>
		                            <#else>
	                            	<div class="charts" style="max-width:200px">
	                                	<canvas id="${(tt.year)!'0'}" width="80" height="80" />
	                                </div>
	                                <script>
		                                var pay01 = document.getElementById("${(tt.year)!'0'}");
		                                var the_data=[${(tt.SJ)!"0"},${(tt.QF)!"0"},${(tt.JM)!"0"},];
		                                var pay01 = new Chart(pay01, {
		                                    type: 'doughnut',
		                                    data: {
		                                        labels: ["已缴", "欠费", "减免"],
		                                        datasets: [{
		                                            data: the_data,
		                                            backgroundColor: [
		                                                "#61bdcd",
		                                                "#dcdcdc",
		                                                "#c23531"
		                                            ],
		                                            hoverBackgroundColor: [
		                                                "#61bdcd",
		                                                "#dcdcdc",
		                                                "#c23531"
		                                            ]
		                                        }]
		                                    },
		                                    options: {
		                                        legend: {
		                                            display: false,
		                                        }
		                                    }
		                                });
		                            </script>
                                </#if>
                            </div>
                            
                            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 border-r">
                                <ul class="pie-data classify-list mt10 stu">
                                    <li class="f16 fb">应缴：￥${((tt.YJ)!"0")?string(',##0.00')}  元</li>
                                    <li class="mt10"><i class="color01"></i>已缴：￥${((tt.SJ)!"0")?string(',##0.00')}  元</li>
                                    <li><i class="color02"></i>欠费：￥${((tt.QF)!"0")?string(',##0.00')}  元</li>
                                    <li><i class="color05"></i>减免：￥${((tt.JM)!"0")?string(',##0.00')}  元</li>
                                </ul>
                            </div>
                            <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2 border-r">
                                <ul class="pie-data classify-list mt10 stu">
                                    <li>学费：<span class="orange-stu">￥${((tt.YJ1)!"0")?string(',##0.00')}  元</span> </li>
                                    <li class="mt10">已缴：￥${((tt.SJ1)!"0")?string(',##0.00')}  元</li>
                                    <li>欠费：￥${((tt.QF1)!"0")?string(',##0.00')}  元</li>
                                    <li>减免：￥${((tt.JM1)!"0")?string(',##0.00')}  元</li>
                                </ul>
                            </div>
                            <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2 border-r">
                                <ul class="pie-data classify-list mt10 stu">
                                    <li>课本费：<span class="orange-stu">￥${((tt.YJ2)!"0")?string(',##0.00')}  元</span> </li>
                                    <li class="mt10">已缴：￥${((tt.SJ2)!"0")?string(',##0.00')}  元</li>
                                    <li>欠费：￥${((tt.QF2)!"0")?string(',##0.00')}  元</li>
                                    <li>减免：￥${((tt.JM2)!"0")?string(',##0.00')}  元</li>
                                </ul>
                            </div>
                            <div class="col-xs-12 col-sm-3 col-md-2 col-lg-2 border-r">
                                <ul class="pie-data classify-list mt10 stu">
                                    <li>住宿费：<span class="orange-stu">￥${((tt.YJ3)!"0")?string(',##0.00')}  元</span> </li>
                                    <li class="mt10">已缴：￥${((tt.SJ3)!"0")?string(',##0.00')}  元</li>
                                    <li>欠费：￥${((tt.QF3)!"0")?string(',##0.00')}  元</li>
                                    <li>减免：￥${((tt.JM3)!"0")?string(',##0.00')}  元</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        </#if>
    </div>
</div>
<script>
    $(".classify-box .ss").click(function () {
        $(this).parents(".classify-box").children(".line-box").toggle();
        $(this).parents("h3").toggleClass("no-bor");
        $(this).find("b").toggleClass("down");
        if ($(this).parents(".classify-box").children(".line-box").css("display")=="none"){
        	$(this).find("i").text("展开详情");
        }else (
        	$(this).find("i").text("收缩详情")
        )
    });
</script>
</body>
</html>
