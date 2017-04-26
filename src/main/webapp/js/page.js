function bdpGotoPageNo(formId,maxPageNo){
	var toPageNo=document.getElementById("bdpGotoPageNo").value;
	
}

function bdpPage(toPageNo,formId,isAjaxForm){
	if(toPageNo==0){
		toPageNo=1;
	}
	var fo=$("#"+formId);
//	var newNode = document.createElement("input");
//	newNode.setAttribute('name','pageNo');
//	newNode.setAttribute('type','hidden');
//	newNode.setAttribute('value',toPageNo);
//	fo.insertBefore(newNode,fo.childNodes[0]); 
	
if($("#"+formId+'pageNo').length==0){
	fo.append($("<input>",{
		id:formId+'pageNo',
		type:'hidden',
		val:toPageNo,
		name:'pageNo',
	}));
}
else{
	$("#"+formId+'pageNo').val(toPageNo);
}
if(isAjaxForm=="true"){
	var opt = {success:eisdResponse};
	fo.ajaxForm(opt); 
}
fo.submit();
}
$(function (){
	$("#gotoPageNumber").keypress(function(event){
		var maxPageNo= $("#gotoPageTotalPageCount").val()*1;
		var toPageNo= $("#gotoPageNumber").val()*1;
//		var formId= $("#gotoPageFormId").val();
		var curKey = event.which; 
        if(curKey == 13){
        	var patrn=/^[0-9]{1,20}$/; 
        	if (!patrn.exec(toPageNo)){
        		comp.message("请输入大于0的整数","error");
        	}else{
        		if(toPageNo<1){
        			comp.message("请输入大于0的整数","error");
        			return false;
        		}else if(toPageNo>maxPageNo){
        			comp.message("请输入小于最大页数的整数","error");
        			return false;
        		}
        		bdpPage(toPageNo,"pageTagFormId");
        	}
        } 
	})});  