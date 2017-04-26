jQuery.fn.anim_progressbar = function (aOptions) {

	// def options
	var aDefOpts = {
		start: new Date(), // now
		
		interval: 1000,
		callback: function() {}
	}
	var aOpts = jQuery.extend(aDefOpts, aOptions);
	var vPb = this;
	var iPerc =0 ; 
	var url=comp.contextPath()+"/sys/sysConfig/getFileProgress.do";
	// each progress bar
	return this.each(
		function() {
			
			// calling original progressbar
			$(vPb).children('.pbar').progressbar();

			// looping process
			var vInterval = setInterval(
				function(){
					
					// display current positions and progress
					$(vPb).children('.percent').html('<b>'+iPerc.toFixed(1)+'%</b>');
					$(vPb).children('.pbar').children('.ui-progressbar-value').css('width', iPerc+'%');
					
					$.ajax({
						async : false,
						cache:false,
						type: 'POST',
						url: url,
						error: function () {
							//iPerc=0;
						},
						success:function(data){ 
							
							iPerc=eval(data)[0].progress;
							
							// in case of Finish
							if (iPerc >= 100) {
								clearInterval(vInterval);
								$(vPb).children('.percent').html('<b>100%</b>');
								$(vPb).children('.pbar').children('.ui-progressbar-value').css('width', '100%');
								aDefOpts.callback.call(this);
							}
						}
					});
					
				} ,aOpts.interval
			);
		}
	);
};


fileupload = {		
		i:1 ,
		create_fileupload_div:function(parent,fileName){
				if(fileName.lastIndexOf("\\")){
						fileName=fileName.substring(fileName.lastIndexOf("\\")+1,fileName.length);
				}
				var id="progress"+this.i;
				var str="<div class=\"fileupload-info\"><a class=\"fileupload-close\" data-dismiss=\"alert\">×</a><strong>"+fileName+"</strong>"
				+"<div id=\""+id+"\" class=\"sepH_b\"><div class=\"percent\"></div><div class=\"pbar\"></div><div class=\"elapsed\"></div></div></div>";
				
				$(parent).append(str);
				
				$('#'+id).anim_progressbar({				
					callback: function() {						
						
					}
				});
				this.i++;
				return $('#'+id).parent();
		}
};