
/* ============= Detele the Workhours field in Enrollment availibility ==========================*/
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
   // $('a.add_standard_fields').attr('disabled',false)
    }
    return event.preventDefault();
  });
/* ============= ADD  workhour fields with Day increment ==========================*/
   $('form').on('click', '.add_fields', function(event) {
   	// $('a.add_standard_fields').attr('disabled',true)

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
   	// $('a.add_standard_fields').attr('disabled',true)
   }
});

/* ============================ADD standards workhour fields===============*/

jQuery(function() {



  $("form").on("click", ".add_standard_fields", function(event) {

    var r=confirm("Would you like to select standard business hours?");
    if (r==true) {
      $('#clear').trigger('click');
       var i, regexp, time;
       i = 1;
       while (i <= 7) {
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
    } else {
        //Do nothing
    } 

  });

/* =========================Add preivous workhours field===============================*/

  $('form').on('click', '.add_previous_fields', function(event) {
    // $('a.add_standard_fields').attr('disabled',true)
    // alert("hellow world");
    var last_visible_select_val = $('fieldset:visible:last').find('select').val();
    var last_selected_start_date_val = $('fieldset:visible:last').find('.start_date').val();
    var last_selected_end_date_val = $('fieldset:visible:last').find('.end_date').val();
    // alert(last_selected_start_date_val);
    // alert(last_selected_end_date_val);
 
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('a.add_fields').before($(this).data('fields').replace(regexp, time));
      switch (last_visible_select_val) {
        case 'm':
           $(this).parent().parent().find("select:last").val('t');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 't':
          $(this).parent().parent().find("select:last").val('w');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 'w':
          $(this).parent().parent().find("select:last").val('th');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 'th':
          $(this).parent().parent().find("select:last").val('f');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 'f':
          $(this).parent().parent().find("select:last").val('s');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 's':
          $(this).parent().parent().find("select:last").val('su');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
          break;
        case 'su':
          $(this).parent().parent().find("select:last").val('m');
           $('fieldset:visible:last').find('.start_date').val(last_selected_start_date_val)
           $('fieldset:visible:last').find('.end_date').val(last_selected_end_date_val)
           break;
        default:
          $(this).parent().parent().find("select:last").val('m');
          // $('fieldset:visible:last').find('.start_date').val('9:00 AM')
          //  $('fieldset:visible:last').find('.end_date').val('5:00 PM')
          break;
      }
    return event.preventDefault();
  });
   if($('fieldset').is(":visible")){
    // $('a.add_standard_fields').attr('disabled',true)
   }
});
// $(document).ready(function(){
//   $('input.start_date').change(function(){
//     alert($(this).val());
//   })
// });
/*Comparing dates*/
$(document).ready(function(){
    $('.zip_code_field').change(function(){
        var country = $('#user_location_attributes_country').val();
        var postal_or_zip = $('.zip_code_field').val();
        /*Validation for US ZipCode */
        if (country == 'United States'){
              var zipcode_regex = /^\d{5}$/;
              if (zipcode_regex.test($.trim(postal_or_zip)) == false){
                  alert('Invalid Zip Code');
              }         
        }
        /*Validation for Canadian postal Code */
        else if (country == 'Canada'){
              var regex = new RegExp(/^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ]( )?\d[ABCEGHJKLMNPRSTVWXYZ]\d$/i);
              if (regex.test(postal_or_zip) == false){
                alert('Invalid Postal Code');
              }
        }

    });     
});
/*Comparing dates*/
$(document).ready(function(){
    $('.zip_code_field').change(function(){
        var country = $('#job_location_attributes_country').val();
        var postal_or_zip = $('.zip_code_field').val();
        /*Validation for US ZipCode */
        if (country == 'United States'){
              var zipcode_regex = /^\d{5}$/;
              if (zipcode_regex.test($.trim(postal_or_zip)) == false){
                  alert('Invalid Zip Code');
              }         
        }
        /*Validation for Canadian postal Code */
        else if (country == 'Canada'){
              var regex = new RegExp(/^[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ]( )?\d[ABCEGHJKLMNPRSTVWXYZ]\d$/i);
              if (regex.test(postal_or_zip) == false){
                alert('Invalid Postal Code');
              }
        }

    });     
});