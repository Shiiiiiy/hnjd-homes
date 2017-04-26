<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>用户导入</title>
		<!-- bootstrap-fileupload -->
		<link rel="stylesheet" href="${rc.contextPath}/lib/bootstrap-fileupload/bootstrap-fileupload.min.css" />
		<script>
			function uploadfile() {
				$("#resultsDiv").attr("class","fileupload-info");
				$("#resultsDiv").html($("#file").val());
			}

			function importUser() {
				if ($("#file").val() == "") {
					comp.message("请选择要导入的excel文件", "error");
					return false;
				}
				$("#fileUpload").submit();
			}

			function goToList() {
				window.location.href = "${rc.contextPath}/user/user/opt-query/queryUser.do";
			}
		</script>
	</head>

	<body>
		<div id="contentwrapper">
			<div class="main_content">
				<div class="row-fluid">
					<form  id="fileUpload"  action="${rc.contextPath}/user/user/opt-query/importUser.do" method="post"  enctype="multipart/form-data">
						<input type="hidden" name="objectId" value="${(logo.id)!""}"/>
						<input type="hidden" name="allowedExt" value="xls"/>
						<input type="hidden" name="maxSize" value="2097152"/>
						<!--2M-->
						<input type="hidden" name="TEMP_FILE" value="SYSCONFIG_FILE_SESSION_KEY"/>
						<!--临时文件存放sessionkey-->
						<div class="formSep">
							<div class="row-fluid">
								<div class="span8">
									<div class="span2">
										下载模板
									</div>
									<div class="span8">
										<div >
											<a href="${rc.contextPath}/excel/template/user.xls">模板下载</a>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span8">
									<div class="span2">
										<label>导入文件<span class="f_req">*</span></label>
									</div>
									<div class="span10" id="_upload_div">
										<div data-fileupload="file" class="fileupload fileupload-new">
											<span class="btn btn-file"> <span class="fileupload-new">选择文件</span>
												<input id="file" type="file" name="file" onchange="uploadfile()">
											</span>
											<div id="resultsDiv"></div>
										</div>
										<div class="alert alert-warning">
											<strong>注意!</strong>
											导入文件时请使用本系统提供的模板,否则可能会导入失败！
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="formSep">
							<div class="row-fluid">
								<div class="span6">
									<p class="btnMargin">
										<button class="btn btn-info" type="button" onclick="importUser()">
											Excel导入
										</button>
										<button class="btn" type="button" onclick="goToList()">
											取消
										</button>
									</p>
								</div>
							</div>
						</div>
					</form>
					<#if importFlag?? && errorText??>
						<div class="formSep">
							<div class="row-fluid">
								<#if (errorText?size > 0)>
									<#list errorText as e>
										<span class="f_req"> ${e!""} </span>
									</#list>
								</#if>
							</div>
						</div>
					</#if>
					<#include "userCompare.ftl">
				</div>
			</div>
		</div>
	</body>
</html>