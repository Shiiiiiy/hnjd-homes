<script>
	$(document).ready(function() {
		//* calculate sidebar height
		rod_sidebar.make();
		//* show all elements & remove preloader
		setTimeout('$("html").removeClass("js")',1000);
	});
</script>