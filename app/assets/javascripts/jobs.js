$(function () {
  $('#datetimepicker1').datetimepicker();
});



$(function () {
  $('#datetimepicker5').datetimepicker({
    pickTime: false
  });
});


$(document).ready(function(){
$('#req_delete1').click(function(){
	$(this).parent('.delete_text').find('input[type=text]').val('')
	// $('#req1').val('');	
})

$('#req_delete2').click(function(){
	$(this).parent('.delete_text').find('input[type=text]').val('')
})

$('#req_delete3').click(function(){
	$(this).parent('.delete_text').find('input[type=text]').val('')
})

$('#req_delete4').click(function(){
	$(this).parent('.delete_text').find('input[type=text]').val('')
})

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




