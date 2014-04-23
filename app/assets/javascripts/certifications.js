$(document).ready(function(){
	
	$("form").bind("ajax:complete",function (event,xhr,status) {
	   $(this).trigger("reset"); 
 });
});