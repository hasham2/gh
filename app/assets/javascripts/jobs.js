$(function () {

  $('#datetimepicker1').datetimepicker();

  $('#datetimepicker5').datetimepicker({
    pickTime: false
  });

  $('#max_distance').val(25);

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

  $("#search_form input[name='certificate_ids[]']").each(function() {
      /* Hide Delete Button if Corresponding TextBox is Empty */
      if ($(this).val() === '') {
        $(this).parent().parent('.delete_text').find('button').hide();
      }
  });

  /* Show Delete Button if Corresponding TextBox is not Emm */
  $("#search_form input[name='certificate_ids[]']").change(function(){
    $(this).parent().parent('.delete_text').find('button').show();
  });

});
