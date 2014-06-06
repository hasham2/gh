$(document).ready(function(){
	
	$("form").bind("ajax:complete",function (event,xhr,status) {
	   $(this).trigger("reset"); 
 });
	$(function() {
	  return $("a[data-remote]").on("ajax:success", function(e, data, status, xhr) {
	  	$(this).closest("tr").hide();
	  });
	});

});

