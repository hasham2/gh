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
