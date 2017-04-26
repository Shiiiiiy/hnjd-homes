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
    <title>教职工信息统计</title>
</head>
<body>
    <h1 class="title">教职工信息统计</h1>
    <div class="container-body">
        <!-- filter -->
        <div class="sort clearfix">
            <div class="fl">
                <form id="form1" role="form" class="clearfix" action="${rc.contextPath}/teacherPortal/opt-query/statistTeacherInfo.do" method="post">
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
                <span class="txt fl mr50 hidden-xs">在校教职工总人数 <b class="num">${(tTeaNumAll)!""}</b><b class="f12"> 人</b></span>
            </div>
        </div>
        <!-- -->
        <div class="row mt20">
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                <div class="box-stu">
                    <h3>校教职工人数汇总统计 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts tc" style="max-width:900px;">
                        <!-- <img src="${rc.contextPath}/css/images/sl.png" alt="示例" />-->
                	        <div class="charts" style="max-width:400px">
                            	<canvas id="zhiwutu" width="160" height="80" /> 	
                            </div>
                            <script>
                                var pay01 = document.getElementById("zhiwutu");
                                var thelength=${(tOrgName?size)!'0'};
                                var thelabels         = new Array(thelength);
						        var thebackgroundColor= new Array(thelength);
						        var theusedata        = new Array(thelength);
                                <#if tOrgName??>
								    <#list tOrgName as ss>
								    	thelabels[${ss_index}]="${ss!''}";
								    	//alert(${ss!''});
								    	thebackgroundColor[${ss_index}]="rgba(98, 171, 184,1)";
								    </#list>
								</#if>
								<#if tTeaNum??>
								    <#list tTeaNum as ss1>
								    	theusedata[${ss1_index}]="${ss1!''}";
								    	//alert(${ss1!''});
								    </#list>
								</#if>
						        var pay01 = new Chart(pay01, {
						            type: 'horizontalBar',
						            data: {
						                labels: thelabels,
						                datasets: [
						                    {
						                        label: "目前人数",
						                        backgroundColor: thebackgroundColor,
						                        data: theusedata,
						                    }
						                ]
						            },
						            options: {
						                legend: {
						                    display: false,
						                },
						                scales: {
						                    yAxes: [{
						                        gridLines: {
						                            display: false,
						                        },
						                    }]
						                },
						            }
						        });
                            </script>
                        </div>
                    </div>
                </div>
                <div class="box-stu">
                    <h3>院系教职工年龄分布统计 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:500px;"><canvas id="count01" /></div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-stu">
                    <h3>院系教职工男女比例统计 (单位:人)</h3>
                    <div class="box-padding">
                        <ul class="sex-list">
                            <li><div class="full-w"><div id="tnv" class="per woman" style="width:50%"><div class="txt" style="text-align:right;">女 ${teacherSexNum[2]!"0"}人<span class="f12"> ${teacherSexNum[3]!"0"}%</span></div></div></div></li>
                            <li class="mt20"><div class="full-w"><div id="tnan" class="per man" style="width:50%"><div class="txt" style="text-align:right;">男 ${teacherSexNum[0]!"0"}人<span class="f12"> ${teacherSexNum[1]!"0"}%</span></div></div></div></li>
                        </ul>
                        <script type="text/javascript">
                        	$(document).ready(function(){
                        		var nan=${teacherSexNum[0]!"0"};
                        		var nv= ${teacherSexNum[2]!"0"};
                        		if(nan>nv){
                        			$("#tnan").css('width','50%');
                        			$("#tnv").css('width','50%');
                        		}else if(nan<nv){
                        			$("#tnan").css('width','50%');
                        			$("#tnv").css('width','50%');
                        		}
                        	});
                        </script>
                    </div>
                </div>
                <div class="box-stu" style="display:none">
                    <h3>院系教职工入离职率对比</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:400px;"><canvas id="count02" /></div>
                    </div>
                </div>
                <div class="box-stu">
                    <h3>院系教职工工龄统计 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:400px;"><canvas id="count03" /></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var count01 = document.getElementById("count01");
        var count02 = document.getElementById("count02");
        var count03 = document.getElementById("count03");
        var datacount03=[${WorkYear[0]!"0"},${WorkYear[1]!"0"},${WorkYear[2]!"0"},${WorkYear[3]!"0"},${WorkYear[4]!"0"},${WorkYear[5]!"0"}];
        var usedata=[${AgeNum[0]!"0"},${AgeNum[1]!"0"},${AgeNum[2]!"0"},${AgeNum[3]!"0"},${AgeNum[4]!"0"},${AgeNum[5]!"0"},${AgeNum[6]!"0"}];
        var count01 = new Chart(count01, {
            type: 'bar',
            data: {
                labels: ["30岁以下", "30-35岁", "35-40岁", "40-45岁", "45-50岁", "50-55岁", "55岁以上"],
                datasets: [
                    {
                        label: "目前人数",
                        backgroundColor: [
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                        ],
                        data: usedata,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                },
                scales: {
                    yAxes: [{
                        gridLines: {
                            display: false,
                        },
                    }]
                },
            }
        });
        var count03 = new Chart(count03, {
            type: 'bar',
            data: {
                labels: ["3年以下", "3-5年", "5-10年", "10-20年", "20-50年", "50年以上"],
                datasets: [
                    {
                        label: "目前人数",
                        backgroundColor: [
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                            'rgba(98, 171, 184,1)',
                        ],
                        data: datacount03,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                },
                scales: {
                xAxes: [{
                        gridLines: {
                            display: false,
                        },
                    }],
                    yAxes: [{
                        gridLines: {
                            display: true,
                        },
                    }]
                },
            }
        });
        var count02 = new Chart(count02, {
            type: 'line',
            data: {
                labels: ["1990年", "1995年", "2000年", "2005年", "2010年", "2015年", "2020年"],
                datasets: [
                    {
                        label: "入职率",
                        fill: true,
                        lineTension: 0.1,
                        backgroundColor: "rgba(145,199,174,0.4)",
                        borderColor: "rgba(75,192,192,1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "rgba(75,192,192,1)",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 10,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "rgba(75,192,192,1)",
                        pointHoverBorderColor: "rgba(220,220,220,1)",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: [10, 20, 0, 10, 30, 35, 40],
                        spanGaps: false,
                    },
                   {
                       label: "离职率",
                       fill: true,
                       lineTension: 0.1,
                       backgroundColor: "rgba(247,100,150,0.4)",
                       borderColor: "rgba(247,100,150,1)",
                       borderCapStyle: 'butt',
                       borderDash: [],
                       borderDashOffset: 0.0,
                       borderJoinStyle: 'miter',
                       pointBorderColor: "rgba(247,100,150,1)",
                       pointBackgroundColor: "#fff",
                       pointBorderWidth: 10,
                       pointHoverRadius: 5,
                       pointHoverBackgroundColor: "rrgba(247,100,150,1)",
                       pointHoverBorderColor: "rgba(220,220,220,1)",
                       pointHoverBorderWidth: 2,
                       pointRadius: 1,
                       pointHitRadius: 10,
                       data: [-20, -30, -10, -15, -25, -21, -19],
                       spanGaps: false,
                   }
                ],
            },
            options: {
                legend: {
                    display: false,
                },
                scales: {
                    xAxes: [{
                        gridLines: {
                            display: false,
                        },
                    }]
                },
            }
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
