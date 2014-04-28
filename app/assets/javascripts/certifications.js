$(document).ready(function(){
	
$(function() {
  return $("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
  	$(this).closest("tr").hide();
  });
});

});