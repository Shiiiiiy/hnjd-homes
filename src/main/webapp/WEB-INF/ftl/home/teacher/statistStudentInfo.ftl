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
    <title>学生信息统计</title>
</head>
<body>
    <h1 class="title">学生信息统计</h1>
    <div class="container-body">
        <!-- filter -->
        <div class="sort clearfix">
            <div class="fl">
                <form id="form1" role="form" class="clearfix" action="${rc.contextPath}/teacherPortal/opt-query/statistStudentInfo.do" method="post">
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
                <span class="txt fl mr50 hidden-xs">校年度总招生人数 <b class="num">${StuNoAll!"0"}</b><b class="f12"> 人</b></span>
            </div>
        </div>
        <!-- -->
        <div class="row mt20">
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                <div class="box-stu">
                    <h3>各学院招生人数汇总统计 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:900px;"><canvas id="count01" /></div>
                    </div>
                </div>
                <div class="box-stu" style="display:none;">
                    <h3>培养类别 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:950px;"><canvas id="count02" /></div>
                    </div>
                </div>
                <div class="box-stu" >
                    <h3>学院学生生源地统计 (单位:人)</h3>
                    <div class="box-padding" ">
                        <div class="charts" style="max-width:450px;"><canvas id="count04" /></div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-stu">
                    <h3>学院历年招生人数统计 (单位:人)</h3>
                    <div class="box-padding">
                        <div class="charts" style="max-width:400px;"><canvas id="count03" /></div>
                    </div>
                </div>
                <div class="box-stu">
                    <h3>学院男女比例统计 (单位:人)</h3>
                    <div class="box-padding">
                        <ul class="sex-list">
                            <li><div class="full-w"><div class="per woman" style="width:50%"><div class="txt">女 ${stusexrate[2]!"0"}人<span class="f12">${(stusexrate[3])!"0"}%</span></div></div></div></li>
                            <li class="mt20"><div class="full-w"><div class="per man" style="width:50%"><div class="txt">男 ${stusexrate[0]!"0"}人<span class="f12">${(stusexrate[1])!"0"}%</span></div></div></div></li>
                        </ul>
                    </div>
                </div>
                <div class="box-stu">
                    <h3>学院学生招生方式统计 (单位:人)</h3>
                    <div class="box-padding clearfix" >
                        <dl class="tj clearfix">
                            <dt><span class="gold">统</span></dt>
                            <dd><div class="back-p"><p class="gold" style="width:${enrollment[1]!"0"}%" title="${enrollment[1]!"0"}%">${(enrollment[0]!"0")}人<span class="f12"></span></p></div></dd>
                        </dl>
                        <dl class="tj clearfix mt20">
                            <dt><span class="blue">单</span></dt>
                            <dd><div class="back-p"><p class="blue" style="width:${enrollment[3]!'0'}%" title="${enrollment[3]!"0"}%">${(enrollment[2]!"0")}人<span class="f12"></span></p></div></dd>
                        </dl>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var count01 = document.getElementById("count01");
        var count02 = document.getElementById("count02");
        var count03 = document.getElementById("count03");
        var count04 = document.getElementById("count04");
        var thelength=${(academyNames?size)!'0'};
        //alert( (typeof thelength)+" "+thelength);
        var labelss = new Array(thelength);
        var bgcolor1= new Array(thelength);
        var bgcolor2= new Array(thelength);
        var bgcolor3= new Array(thelength);
        var data01= new Array(thelength);
        var data02= new Array(thelength);
        var data03= new Array(thelength);
        <#if academyNames??>
	        <#list academyNames as ss>
	        	labelss[${ss_index}]="${ss!''}";
	        	bgcolor1[${ss_index}]="rgba(157,230,227, 1)";
	        	bgcolor2[${ss_index}]="rgba(150, 191, 197, 1)";
	        	bgcolor3[${ss_index}]="rgba(173,214, 194, 1)";
	        </#list>
        </#if>
        <#if bar1??>
	        <#list bar1 as bb>
	        	<#if bb_has_next>
	        	data01[${bb_index}]="${bb!''}";
	        	</#if>
	        </#list>
        </#if>
        <#if bar2??>
	        <#list bar2 as bb>
	        	<#if bb_has_next>
	        	data02[${bb_index}]="${bb!''}";
	        	</#if>
	        </#list>
        </#if>
        <#if bar3??>
	        <#list bar3 as bb>
	        	<#if bb_has_next>
	        	data03[${bb_index}]="${bb!''}";
	        	</#if>
	        </#list>
        </#if>
        //alert(data03);
        var count01 = new Chart(count01, {
            type: 'horizontalBar',
            data: {
                labels: labelss ,
                datasets: [
                    {
                        label: "${(baryear[0])!''}学年",
                        backgroundColor: bgcolor1 ,
                        data: data01,
                    }, {
                        label: "${(baryear[1])!''}学年",
                        backgroundColor: bgcolor2 ,
                        data: data02,
                    }, {
                        label: "${(baryear[2])!''}学年",
                        backgroundColor: bgcolor3,
                        data: data03
                    }
                ]
            },
            options: {
                legend: {
                    display: true,
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
        var count02 = new Chart(count02, {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: [15, 30, 40, 20],
                    backgroundColor: [
                        "#2f4554",
                        "#61a0a8",
                        "#91c7ae",
                        "#c23531",
                    ],
                    label: 'My dataset' // for legend
                }],
                labels: ["普通本科学", "普通中职学生", "普通专科学生", "三年制大专"]
            },
            options: {
                legend: {
                    display: true,
                },
            }
        });
        var count03 = new Chart(count03, {
            type: 'line',
            data: {
                labels: ["${(listforline[0])!''}", "${(listforline[1])!''}", "${(listforline[2])!''}"],
                datasets: [
                    {
                        label: "共招生人数",
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
                        data: [${(listforline[3])!''}, ${(listforline[4])!''}, ${(listforline[5])!''}],
                        spanGaps: false,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                },
                scales: {
                    yAxes: [{

                    }]
                },
            }
        });
        var tehshenyuan=[${shenyuandi[1]!'0'},${shenyuandi[0]!'0'},];
        var count04 = new Chart(count04, {
            type: 'horizontalBar',
            data: {
                labels: ["外地生源", "本地生源",],
                datasets: [
                    {
                        label: "目前人数",
                        backgroundColor: [
                            'rgba(98, 171, 184,1)',
                            'rgba(157,230,227, 1)',
                        ],
                        data: tehshenyuan,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                },
                scales: {
                    xAxes: [{
                            display: true,
                    }],
                    yAxes: [{
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
