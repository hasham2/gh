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
  $('form').on('click', '.remove_fields', function(event) {
    var condition = $(this).closest('fieldset').find('select').val();
    // alert(condition);
    switch (condition) {
      case 'm':
         $(this).closest('fieldset').find('select').val('su');
        break;
      case 'su':
        $(this).closest('fieldset').find('select').val('s');
        break;
      case 's':
        $(this).closest('fieldset').find('select').val('f');
        break;
      case 'f':
        $(this).closest('fieldset').find('select').val('th');
        break;
      case 'th':
        $(this).closest('fieldset').find('select').val('w');
        break;
      case 'w':
        $(this).closest('fieldset').find('select').val('t');
        break;
      case 't':
        $(this).closest('fieldset').find('select').val('m');
         break;
    }
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    if($('fieldset').is(":visible")){
    // do nothing
    }
    else{
    $('a.add_standard_fields').attr('disabled',false)
    }
    return event.preventDefault();
  });

   $('form').on('click', '.add_fields', function(event) {
   	$('a.add_standard_fields').attr('disabled',true)

    var last_visible_select_val = $('fieldset:visible:last').find('select').val();

    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
     
      switch (last_visible_select_val) {
        case 'm':
           $(this).parent().parent().find("select:last").val('t');
          break;
        case 't':
          $(this).parent().parent().find("select:last").val('w');
          break;
        case 'w':
          $(this).parent().parent().find("select:last").val('th');
          break;
        case 'th':
          $(this).parent().parent().find("select:last").val('f');
          break;
        case 'f':
          $(this).parent().parent().find("select:last").val('s');
          break;
        case 's':
          $(this).parent().parent().find("select:last").val('su');
          break;
        case 'su':
          $(this).parent().parent().find("select:last").val('m');
           break;
        default:
          $(this).parent().parent().find("select:last").val('m');
          break;
      }

    

    return event.preventDefault();
  });
   if($('fieldset').is(":visible")){
   	$('a.add_standard_fields').attr('disabled',true)
   }
});



jQuery(function() {
  $("form").on("click", ".add_standard_fields", function(event) {
    var i, regexp, time;
    i = 1;
    while (i < 7) {
      regexp = void 0;
      time = void 0;
      time = new Date().getTime();
      regexp = new RegExp($(this).data("id"), "g");
      $("a.add_fields").before($(this).data("fields").replace(regexp, time));
      switch (i) {
        case 1:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("m");
          break;
        case 2:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("t");
          break;
        case 3:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("w");
          break;
        case 4:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("th");
          break;
        case 5:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("f");
          break;
        case 6:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("s");
          break;
        case 7:
          $("#user_work_hours_attributes_" + time + "_day_of_week").val("su");
      }
      i++;
    }
    return event.preventDefault();
  });
});
