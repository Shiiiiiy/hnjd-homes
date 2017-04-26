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
    <title>新闻</title>
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
        <div class="row">
            <h2 style="padding:0 5px;"><a href="<#if login_userType?? && login_userType=='STUDENT'>${rc.contextPath}/studentPortal/opt-query/studentPortalShow.do<#elseif  login_userType?? && login_userType=='TEACHER' && login_isSuperUser?? && login_isSuperUser='1'>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do?superuser=true<#else>${rc.contextPath}/menhu/opt-query/queryMenhuNewsList.do</#if>" class="fr backto">返回主页</a><#if publish_news??&&publish_news=="ok"><a href="${rc.contextPath}/menhu/opt-add/addNewsView.do" class="fr backto mr10">发布新闻</a></#if>新闻公告</h2>
            <div class="col-xs-12 col-sm-3 col-md-3 col-lg-3 teacher-list">
                <div class="news-menu clearfix">
                    <h3><i class="news-icon"></i>信息类别</h3>
                    <ul>
                        
                        <#if newsTypeList??>
                        <#list newsTypeList as ntl>
                             <#if (typeId)?? && ntl.id==typeId> 
                                 <li class="active"><a href="javascript:void(0);" id="${(ntl.id)!''}" onclick="getNewsList(this)"><i class="news-icon news0${ntl_index+1}"></i>${(ntl.mhName)!""}</a></li>
                             <#else>
                                 <li ><a href="javascript:void(0);" id="${(ntl.id)!''}" onclick="getNewsList(this)"><i class="news-icon news0${ntl_index+1}"></i>${(ntl.mhName)!""}</a></li>
                             </#if>    
                        </#list>
                        </#if>
                       <#if caogao?? && caogao=="ok"> 
	                        <#if typeId?? && "caogao"==typeId>
	                                 <li class="active"><a href="javascript:void(0);" id="caogao" onclick="getNewsList(this)"><i class="news-icon news04"></i>新闻草稿</a></li>
	                       <#else>
	                                 <li><a href="javascript:void(0);" id="caogao" onclick="getNewsList(this)"><i class="news-icon news04"></i>新闻草稿</a></li>
	                        </#if>
                       </#if>  
                    </ul>
                </div>
            </div>
            <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9 teacher-list">
                <div class="news-list clearfix">
                    <div class="search clearfix">
                        <form id="seaching" action="${rc.contextPath}/menhu/opt-query/queryNewsList.do" method="post">
                            <ul class="clearfix">
                                <input type="text" id="typeId" name="typeId"  hidden value="${typeId!''}" />
                                <li class="input-s"><input type="text" class="input-text" id="search" value="${(search)!''}" name="search" placeholder="请输入关键字" /></li>
                                <li class="input-b"><button value="" class="news-icon sf" onclick="subForms()"></button></li>
                            </ul>
                        </form>
                    </div>
                    <div class="list-con">
                        <ul id="newsPage">
                            <#if page??>
									<#list page.result as ns>
                                          <#if ns??>
                                                <li class="clearfix">
                                                
                                                <#if delete_news??&&delete_news=="ok"><i  title="删除" id="${(ns.id)!''}" name="<#if ns.status??&&ns.status.mhCode??><#if ns.status.mhCode=='UNPUBLISHED'>B<#elseif ns.status.mhCode=='PUBLISHED'>A</#if></#if>" class="iconfont close-news" onclick="showWIN(this)">&#xe609;</i></#if><#if ns.status??&&  ns.status.mhCode?? &&ns.status.mhCode=="UNPUBLISHED"><i title="发布" name="${(ns.id)!''}" class="iconfont pub-news" onclick="publishNews(this)">&#xe611;</i><i class="iconfont editor-news" title="编辑" name="${(ns.id)!''}" onclick="editNews(this)">&#xe607;</i></#if>
                                                <a href="${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId=${(ns.id)!''}&typeId=${(ns.mhNewsType.id)!''}&newStat=B"><i class="news-icon newslist0<#if ns.mhNewsType?? && ns.mhNewsType.mhCode?? ><#if ns.mhNewsType.mhCode=='CHECK_INFO'>1<#elseif ns.mhNewsType.mhCode=='FAMALY_INFO'>2<#elseif ns.mhNewsType.mhCode=='TEST_INFO'>3</#if></#if>"></i><div class="fl"><h3>${(ns.mhNewsType.mhName)!""}</h3><p>${((ns.mhNewsTitle)!"")?html}</p></div><span class="fr date"><#if ns.updateTime??>${(ns.updateTime)?string("yyyy-MM-dd")}</#if></span></a>
                                                </li>
                                          </#if>
									</#list>
							</#if>
                            
                        </ul>
                    </div>
                    <div style="padding:20px;">
                        <input type="text" id="pageNo" name="pageNo"  hidden value="${(pageNo)!''}" />
                        <a href="javascript:void(0);" id="getMores" onclick="getMoreNews()"  style="display:block;background:#f2f2f2;line-height:30px; text-align:center;">加载更多</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <!--弹窗-->
    <div class="popup-back" style="display:none;"></div>
    <div class="popup-content" style="display:none;">
        <h4><span class="fr close-x">X</span><B>提示</B></h4>
        <p class="main f16">确认删除吗？</p>
        <input type="hidden" id="newsId" value=""/>
        <input type="hidden" id="delAB" value=""/>
        <p class="tr"><button type="button" class="btn-s cancel-btn">取消</button><button type="button" class="btn-s confirm-btn" onclick="deleteNews()">确定</button></p>
    </div>
    
    <script>
        $(function () {
            $("#Searchresult a.del-btn").click(function () {
                $("#newsId").val($(this).attr("id"));
                $("#delAB").val($(this).attr("name"));
                
                $("div.popup-back, div.popup-content").fadeIn();
            });
            $(".btn-s, span.close-x").click(function () {
                $(".popup-back, .popup-content").fadeOut();
            });
            
             $(".input-text").focus(function () {
                    this.placeholder = '';
            });
            $(".input-text").blur(function () {
                    this.placeholder = "请输入关键字";
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
        
        
        function getNewsList(obj){
             var st=$("li[class='active']").removeClass("active");
             $(obj).addClass("active");
             //$("#showlistcolor").addClass("active");
             var tas=$(obj).attr("id");
             $("#typeId").val(tas);
             $("#search").val("");
             $("#seaching").submit();
        }
        
        function subForms(){
             var search= $("#search").val();
             var search=search.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'');
             document.getElementById("search").value=search;
             $("#seaching").submit();
        }
        
        function getMoreNews(){
              var search= $("#search").val();
              var search=search.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'');
              
              $.ajax({ 
						type:"post",
						url:"${rc.contextPath}/menhu/opt-query/queryMoreNewsList.do",
						data:{"search":search,"typeId":$("#typeId").val(),"pageNo":$("#pageNo").val()},
						dataType:"json",
						success:function(data){
						     var count=1;
						     if(data.result=="no"){ 
							       $("#getMores").text("已全部加载完");
							       $("#getMores").addClass("hidemouse");
						      }else{
						          $("#pageNo").val(data.pageNo);
							      var str="";
							      $.each(data.result, function (n, value) {  
							           var nameStat="";
							           var strss="";
							           var strss01="";
							           var delete_news="${(delete_news)!''}";
							           
							           
							           if(value.status=="ok"){
							              nameStat="A";
							           }else if(value.status=="no"){
							              nameStat="B";   
							              strss="<i title='发布' name='"+value.id+"' class='iconfont pub-news' onclick='publishNews(this)'>&#xe611;</i><i class='iconfont editor-news' title='编辑' name='"+value.id+"' onclick='editNews(this)'>&#xe607;</i>";
							           }
							           if(value.mhNewsTypeId=="CHECK_INFO"){
							               count=1;
							           }else if(value.mhNewsTypeId=="FAMALY_INFO"){
							               count=2;
							           }else if(value.mhNewsTypeId=="TEST_INFO"){
							               count=3;
							           }
							           
							           if(delete_news=="ok"){
							               strss01="<i class='iconfont close-news' title='删除' id='"+value.id+"' onclick='showWIN(this)' name='"+nameStat+"' >&#xe609;</i>";
							           }
							           
							           
						               str=str+"<li class='clearfix'>"+strss01+"<a href='${rc.contextPath}/menhu/opt-query/queryNewsDetail.do?mhNewsId="+value.id+"&typeId="+value.mhNewsTypeCode+"&newStat=B'><i class='news-icon newslist0"+count+"'></i>"+strss+"<div class='fl'><h3>"+value.mhNewsTypeName+"</h3><p>"+value.mhNewsTitle.replace(/</g,"&lt;").replace(/>/g,"&gt;")+"</p></div><span class='fr date'>"+value.newTime+"</span></a></li>";
						               
						          });  
							      $("#newsPage").append(str);
						      } 
					    } 
		     }); 
        }
        
        function deleteNews(){
            var str=$("#newsId").val();
            var str01=$("#delAB").val();
            var stat="";
            if(str01=="A"){
               stat="del_a";
            }else if(str01=="B"){
               stat="del_b";
            }
            $.ajax({ 
						type:"post",
						url:"${rc.contextPath}/menhu/opt-del/deleteNews.do",
						data:{"mhNewsId":str,"stat":stat},
						dataType:"text",
						success:function(data){
						      var ob=$("#"+str);
						      ob.parent().fadeOut();
						       
					    } 
		     }); 
        }
        
        function editNews(obj){
             var str=$(obj).attr("name");
             window.location.href="${rc.contextPath}/menhu/opt-add/addNewsView.do?mhNewsId="+str;
            
        }
        
        function showWIN(obj){
             $("#newsId").val($(obj).attr("id"));
             $("#delAB").val($(obj).attr("name"));
             $("div.popup-back, div.popup-content").fadeIn();
        }
        
        
        function publishNews(obj){
             var str=$(obj).attr("name");
             window.location.href="${rc.contextPath}/menhu/opt-save/saveNews.do?mhNewsId="+str+"&pubs=ok";
        }
        
        
        
    </script>
    <script>
        $(function () {
            $(".list-con").delegate("li", "mouseover mouseout", function (event) {
                if (event.type == "mouseover") {
                    $(this).find("i.close-news").show();
                    $(this).find("i.editor-news").show();
                    $(this).find("i.pub-news").show();
                } else if (event.type == "mouseout") {
                    $(this).find("i.close-news").hide();
                    $(this).find("i.editor-news").hide();
                    $(this).find("i.pub-news").hide();
                }
            });
        });
        
    </script>
</body>
</html>
