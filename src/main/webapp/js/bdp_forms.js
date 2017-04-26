/*用于form extends 样式 ,根据需要加，参加rod_forms.js*/

	$(document).ready(function() {
		//* nice form elements
        rod_uniform.init();
	});
    //* uniform
    rod_uniform = {
		init: function() {
            $(".uni_style").uniform();
        }
    };