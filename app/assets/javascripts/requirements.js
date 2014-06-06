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

jQuery(function() {

   $('form').on('click', '.add_standard_fields', function(event) {
   	 for (var i = 0; i < 7; i++) {
   	var regexp, time;
   	time = new Date().getTime();
   	regexp = new RegExp($(this).data('id'), 'g');
   	//alert($(this).id);
   	// $(this).before.($('.add_fields'))
   	 $('a.add_fields').before($(this).data('fields').replace(regexp, time));
   	
   	 }
   	return event.preventDefault(); 
  });
});
