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
    <![endif] -->
    <title>缴费信息统计</title>
</head>
<body>
<h1 class="title">缴费信息统计</h1>
<div class="container-body">
<!-- filter -->
<div class="sort clearfix">
    <div class="fl">
        <form id="form1" role="form" class="clearfix" action="${rc.contextPath}/teacherPortal/opt-query/statistStudentTuition.do" method="post">
            <input type="hidden" id="default_on" name="default_on" value="${default_on!'square'}"/>
            <script type="text/javascript">
                $(document).ready(function(){
                    var zhi="${default_on!'square'}";
                    //alert(zhi);
                    if(zhi=="line"){
                        $("a.line").addClass("line-open");
                        $("a.square").removeClass("square-open");
                        $("#shuiping").css('display','block');
                        $("#gongge").css('display','none');
                        $("#default_on").val("line");
                    };
                });
            </script>
            <select id="xuenain" class="mr50" name="schyear">
                <#if schyearList?? && (schyearList?size>0) >
                    <#list schyearList as cc>
                        <#if schyear?? && cc == schyear >
                            <option  value="${cc}" selected="selected">${cc}学年</option>
                            <#else>
                                <option value="${cc}">${cc}学年</option>
                        </#if>
                    </#list>
                    <#else>
                        <option value="" >学年</option>
                </#if>
            </select>
            <select id="xueyuan" name="academyN">
                <#if academyList?? && (academyList?size>0)>
                    <#list academyList as cc>
                        <#if academyN?? && cc == academyN >
                            <option  value="${cc}" selected="selected">${cc}</option>
                            <#else>
                                <option value="${cc}">${cc}</option>
                        </#if>
                    </#list>
                    <#else>
                        <option value="" >学院</option>
                </#if>
            </select>
        </form>
    </div>
    <div class="fr">
        <span class="txt fl mr50 hidden-xs">校年度缴费学生总数 <b class="num"><#if MHstuFeeListAll??>${(MHstuFeeListAll.ZRS)!"0"}</#if></b><b class="f12"> 人</b></span>
        <a title="切换宫格视图" href="#" class="square square-open" id></a>
        <a title="切换多行视图" href="#" class="line"></a>
    </div>
</div>
<!-- survey  第一张大图  汇总图-->
<div class="main-infor clearfix">

    <div class="row">
        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                <p class="tc"><B>校缴费信息汇总统计</b></p>
                    <#if (MHstuFeeListAll.JFZT)?? && MHstuFeeListAll.JFZT=="全部缴清">
                        <div align="center">
                            <img src="${rc.contextPath}/css/images/no1.png" alt="${(MHstuFeeListAll.JFZT)!""}" />
                            <p style="color:green;">${(MHstuFeeListAll.JFZT)!""}</p>
                        </div>
                        <#elseif MHstuFeeListAll.JFZT=="无人缴费">
                            <div align="center">
                                <img src="${rc.contextPath}/css/images/no.png" alt="${(MHstuFeeListAll.JFZT)!""}" />
                                <p>${(MHstuFeeListAll.JFZT)!""}</p>
                            </div>
                            <#else>
                                <div class="charts">
                                    <canvas id="pay" width="160" height="120" />
                                </div>
                                <script>
                                    var dataJiaofei=[${(MHstuFeeListAll.WQJF)!"0"},${(MHstuFeeListAll.BFJF)!"0"},${(MHstuFeeListAll.WJF)!"0"},];
                                    var ctx = document.getElementById("pay");
                                    var ctx = new Chart(ctx, {
                                        type: 'pie',
                                        data: {
                                            labels: ["已缴费", "部分缴费", "未缴费",],
                                            datasets: [{
                                                data: dataJiaofei,
                                                backgroundColor: [
                                                    "#61bdcd",
                                                    "#93d8b8",
                                                    "#dcdcdc"
                                                ],
                                                hoverBackgroundColor: [
                                                    "#61bdcd",
                                                    "#93d8b8",
                                                    "#dcdcdc"
                                                ]
                                            }]
                                        },
                                        options: {
                                            legend: {
                                                display: false,
                                            },
                                            tooltips: {
							                    bodyFontSize: 11,
							                }
                                        }
                                    });
                                </script>
                    </#if>
                </div>

                <div class="col-md-6 col-lg-6 hidden-xs hidden-sm" width="630px" >
                    <ul class="pie-data">
                        <li><i class="color01"></i>已缴费:<#if MHstuFeeListAll??>${(MHstuFeeListAll.WQJF)!"0"}</#if>人</li>
                        <li><i class="color02"></i>未缴费:<#if MHstuFeeListAll??>${(MHstuFeeListAll.WJF)!"0"}</#if>人</li>
                        <li><i class="color03"></i>部分缴:<#if MHstuFeeListAll??>${(MHstuFeeListAll.BFJF)!"0"}</#if>人</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                <div style="width:90%;">
                    <canvas id="mianTU" height="80"/><!-- 下方的统计图-->
                    <script>
                    	var payzhu = document.getElementById("mianTU");
                    	var data1=[${(MHstuFeeListAll.WQJF2)!"0"},${(MHstuFeeListAll.WQJF3)!"0"},${(MHstuFeeListAll.WQJF1)!"0"}];
                    	var data2=[${(MHstuFeeListAll.WJF2)!"0"},${(MHstuFeeListAll.WJF3)!"0"},${(MHstuFeeListAll.WJF1)!"0"}];
                    	var data3=[${(MHstuFeeListAll.BFJF2)!"0"},${(MHstuFeeListAll.BFJF3)!"0"},${(MHstuFeeListAll.BFJF1)!"0"}];
                        var payzhu = new Chart(payzhu, {
								type: 'horizontalBar',
					            data: {
					                labels: ["教材费","学费","住宿费",] ,
					                datasets: [
					                    {
					                        label: "部分缴费",
					                        backgroundColor: ["#93d8b8","#93d8b8","#93d8b8"],
					                        data: data3,
					                    }, {
					                        label: "未缴费",
					                        backgroundColor: ["#dcdcdc","#dcdcdc","#dcdcdc"],
					                        data: data2,
					                    }, {
					                        label: "已缴费",
					                        backgroundColor: ["#61bdcd","#61bdcd","#61bdcd"],
					                        data: data1,//已交费的 学费 住宿费 教材费
					                    }
					                ]
					            },
					            options: {
					                legend: {
					                    display: false,
					                },
					            }
                        });
                    </script>
                </div>
            
        </div>
    </div>
</div>
<!-- 宫格图切换的部分-->
<div class="row mt20 square-view" id="gongge">
    <#if academyList?? && (academyList?size>0) >
        <#list academyList as xueyuan>
            <#list MHstuFeeList as aa>
                <#if aa.XYMC == xueyuan>
                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3">
                        <div class="classify-box">
                            <h3>${(aa.XYMC)!""}<span class="lable-classify">${(aa.ZRS)!""}人</span></h3>
                            <div class="classify-content">
                                <#if (aa.JFZT)?? && aa.JFZT == "无人缴费" >
                                    <div class="nodata tc"><img src="${rc.contextPath}/css/images/no.png" alt="无人缴费" /><p>无人缴费</p></div>
                                    <div class="row fixhight" style="display:none;">
                                        <div class="col-xs-6 col-sm-12 col-md-6 col-lg-6"><div class="charts"><canvas id="pie01" height="300" /></div></div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 hidden-sm">
                                            <ul class="pie-data classify-list">
                                                <li><i class="color01"></i>已缴费：${(aa.WQJF)!""}人</li>
                                                <li><i class="color02"></i>未缴费：${(aa.WJF)!""}人</li>
                                                <li><i class="color03"></i>部分缴：${(aa.BFJF)!""}人</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <#elseif aa.JFZT == "全部缴清" >
                                    <div class="nodata tc"><img src="${rc.contextPath}/css/images/no1.png" alt="全部缴清" /><p>全部缴清</p></div>
                                    <div class="row fixhight" style="display:none;">
                                        <div class="col-xs-6 col-sm-12 col-md-6 col-lg-6"><div class="charts"><canvas id="pie01" height="300" /></div></div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 hidden-sm">
                                            <ul class="pie-data classify-list">
                                                <li><i class="color01"></i>已缴费：${(aa.WQJF)!""}人</li>
                                                <li><i class="color02"></i>未缴费：${(aa.WJF)!""}人</li>
                                                <li><i class="color03"></i>部分缴：${(aa.BFJF)!""}人</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <#else>
                                    <div class="row fixhight">
                                        <div class="col-xs-6 col-sm-12 col-md-6 col-lg-6 teacher-list"><div class="charts overheight">
                                            <canvas id="${(aa.XYMC)!''}" height="180"/></div></div>
                                        <div class="col-xs-6 col-md-6 col-lg-6 hidden-sm teacher-list">
                                            <ul class="pie-data classify-list">
                                                <li><i class="color01"></i>已缴费：${(aa.WQJF)!""}人</li>
                                                <li><i class="color02"></i>未缴费：${(aa.WJF)!""}人</li>
                                                <li><i class="color03"></i>部分缴：${(aa.BFJF)!""}人</li>
                                            </ul>
                                        </div>
                                        <#if (aa.JFZT)?? && aa.JFZT =="部分缴费" >
                                            <script>
                                                var tehdata=[${(aa.WQJF)!'0'},${(aa.BFJF)!'0'},${(aa.WJF)!'0'},];
                                                //alert(${(aa.XYMC)!''});
                                                var listpie01 = document.getElementById("${(aa.XYMC)!''}");
                                                var listpie01 = new Chart(listpie01, {
                                                    type: 'doughnut',
                                                    data: {
                                                        labels: ["已缴费", "部分缴费", "未缴费"],
                                                        datasets: [{
                                                            data: tehdata,
                                                            backgroundColor: [
                                                                "#61bdcd",
                                                                "#93d8b8",
                                                                "#dcdcdc"
                                                            ],
                                                            hoverBackgroundColor: [
                                                                "#61bdcd",
                                                                "#93d8b8",
                                                                "#dcdcdc"
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
                                </#if>
                                <div class="charts mt30">
                                    <canvas id="${aa_index+1024}" height="200" /><!-- 下方的统计图-->
                                    <script>
                                    	var payzhu = document.getElementById(${aa_index+1024});
                                        var data1=[${(aa.WQJF2)!"0"},${(aa.WQJF3)!"0"},${(aa.WQJF1)!"0"}];
					                	var data2=[${(aa.WJF2)!"0"},${(aa.WJF3)!"0"},${(aa.WJF1)!"0"}];
					                	var data3=[${(aa.BFJF2)!"0"},${(aa.BFJF3)!"0"},${(aa.BFJF1)!"0"}];
                                        var payzhu = new Chart(payzhu, {
												type: 'horizontalBar',
									            data: {
									                labels: ["教材费","学费","住宿费",] ,
									                datasets: [
									                    {
									                        label: "部分缴费",
									                        backgroundColor: ["#93d8b8","#93d8b8","#93d8b8"],
									                        data: data3
									                    }, {
									                        label: "未缴费",
									                        backgroundColor: ["#dcdcdc","#dcdcdc","#dcdcdc"],
									                        data: data2,
									                    }, {
									                        label: "已缴费",
									                        backgroundColor: ["#61bdcd","#61bdcd","#61bdcd"],
									                        data: data1,
									                    }
									                ]
									            },
									            options: {
									                legend: {
									                    display: false,
									                },
									            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </#list>
        </#list>
    </#if>
</div>
<!-- ==========水平图切换后效果======== -->
<div class="mt20 line-view" style="display: none;" id="shuiping">
    <#if academyList?? && (academyList?size>0) >
        <#list academyList as xueyuanM>
            <#list MHstuFeeList as bb>
                <#if bb.XYMC == xueyuanM>
                    <div class="classify-box">
                        <h3>${(bb.XYMC)!""}<span class="lable-classify">${(bb.ZRS)!"0"}人</span></h3>
                        <div class="line-box">
                            <div class="row">
                                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 col-lg-offset-1 col-md-offset-1">
                                    <div class="charts" style="max-width:200px">
                                        <#if (bb.JFZT)?? && bb.JFZT == "无人缴费" >
                                            <div class="nodata tc" style="height:90;"><img src="${rc.contextPath}/css/images/no.png" alt="无人缴费" /><p>无人缴费</p></div>
                                            <#elseif bb.JFZT == "全部缴清">
                                                <div class="nodata tc" style="height:90;"><img src="${rc.contextPath}/css/images/no1.png" alt="全部缴清" /><p>全部缴清</p></div>
                                                <#else>
                                                    <canvas id="${(bb_index+235400)!""}" width="80" height="80" />
                                                    <script>
                                                        var pieLinelistdata=[${(bb.WQJF)!'0'},${(bb.BFJF)!'0'},${(bb.WJF)!'0'},];
                                                        var pieLinelist = document.getElementById("${(bb_index+235400)!""}");
                                                        var pieLinelist = new Chart(pieLinelist, {
                                                            type: 'doughnut',
                                                            data: {
                                                                labels: ["已缴费", "部分缴费", "未缴费"],
                                                                datasets: [{
                                                                    data: pieLinelistdata,
                                                                    backgroundColor: [
                                                                        "#61bdcd",
                                                                        "#93d8b8",
                                                                        "#dcdcdc"
                                                                    ],
                                                                    hoverBackgroundColor: [
                                                                        "#61bdcd",
                                                                        "#93d8b8",
                                                                        "#dcdcdc"
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
                                </div>
                                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                    <ul class="pie-data classify-list mt10">
                                        <li><i class="color01"></i>已缴费：${(bb.WQJF)!"0"}人</li>
                                        <li><i class="color02"></i>未缴费：${(bb.WJF)!"0"}人</li>
                                        <li><i class="color03"></i>部分缴：${(bb.BFJF)!"0"}人</li>
                                    </ul>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-5 col-lg-5">
                                    <div class="charts mt10">
                                        <canvas id="${bb_index+20480}" height="100" />
                                    </div>
                                    <script>
                                        //var payLinedata=[${(bb.SYDDK)!"0"}, ${(bb.XYDDK)!"0"},${(bb.HJRS)!"0"}, ${(bb.JXJRS)!"0"}, ${(bb.ZXJRS)!"0"},];
                                        var payLinelist = document.getElementById("${bb_index+20480}");
                                        var data1=[${(bb.WQJF2)!"0"},${(bb.WQJF3)!"0"},${(bb.WQJF1)!"0"}];
					                	var data2=[${(bb.WJF2)!"0"},${(bb.WJF3)!"0"},${(bb.WJF1)!"0"}];
					                	var data3=[${(bb.BFJF2)!"0"},${(bb.BFJF3)!"0"},${(bb.BFJF1)!"0"}];
                                        var payLinelist = new Chart(payLinelist, {
												type: 'horizontalBar',
									            data: {
									                labels: ["教材费","学费","住宿费",] ,
									                datasets: [
									                    {
									                        label: "部分缴费",
									                        backgroundColor: ["#93d8b8","#93d8b8","#93d8b8"],
									                        data: data3
									                    }, {
									                        label: "未缴费",
									                        backgroundColor: ["#dcdcdc","#dcdcdc","#dcdcdc"],
									                        data: data2,
									                    }, {
									                        label: "已缴费",
									                        backgroundColor: ["#61bdcd","#61bdcd","#61bdcd"],
									                        data: data1,
									                    }
									                ]
									            },
									            options: {
									                legend: {
									                    display: false,
									                },
									            }
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </#list>
        </#list>
    </#if>
</div>
<script>
    $(function () {
        $("a.square").click(function () {
            $(this).addClass("square-open");
            $("a.line").removeClass("line-open");
            $(".square-view").fadeIn(200);
            $(".line-view").fadeOut(200);
            $("#default_on").val("square");
        });
        $("a.line").click(function () {
            $(this).addClass("line-open");
            $("a.square").removeClass("square-open");
            $(".square-view").fadeOut(200);
            $(".line-view").fadeIn(200);
            $("#default_on").val("line");
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#xuenain").change(function(){
            $("#form1").submit();
        });
        $("#xueyuan").change(function(){
            $("#form1").submit();
        });
    });
</script>
</body>
</html>