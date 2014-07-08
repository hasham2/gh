$(function () {
  $('#datetimepicker1').datetimepicker();
});



$(function () {
  $('#datetimepicker5').datetimepicker({
    pickTime: false
  });
});





$(document).ready(function(){
  $('#max_distance').val(25);
});


$(document).ready(function(){

  /*****enable text field based upon selection of radio butoon in search ********/
    $('.enable_checkbox').click(function(){
      if($('#enable_radio_button_1').is(":checked")){
        $('#hourly_pay').attr('disabled',false)
        $('#fixed_price').attr('disabled',true).val('');   
      }
      if ($('#enable_radio_button_2').is(":checked")) {
      $('#hourly_pay').attr('disabled',true).val(''); 
        $('#fixed_price').attr('disabled',false); 
      };
      
    });
});


$(document).ready(function(){

  $("#search_form input[name='certificate_ids[]']").each(function() {
      /*Hide Delete Button if Corresponding TextBox is Empty*/
      if ($(this).val()=='') {
        $(this).parent().parent('.delete_text').find('button').hide();
      }
  });
  /*Show Delete Button if Corresponding TextBox is not Emm*/
  $("#search_form input[name='certificate_ids[]']").change(function(){
    $(this).parent().parent('.delete_text').find('button').show();

  });

});



