

$(document).ready(function(){
	var address=""
	var city=""
	var country=""
	var state=""

	$('.address_field').change(function(){
		  address = $('.address_field').val();
		 address = address+","
		$('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('.city_field').change(function(){
		 city = $('.city_field').val();
		 city = city+","
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('#job_location_attributes_state').change(function(){
		 state = $('#job_location_attributes_state').val();
		 state = state+","
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('#job_location_attributes_country').change(function(){
		 country = $('#job_location_attributes_country').val();
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});


	$('#add_certification').click(function(){
		var new_certification =	$('#add_certification_value').val();
		if (new_certification == ""){

			alert('Please Enter some Value')
		}else{
		// alert(new_certification);
			$.ajax({
			   method:'post',
			   url:'./add_certification',
			   data: {value:new_certification}
			 });

			$('#add_certification_value').val("");
		}	

	});








	// $('#simple_slider').slider({
	// 	formater: function(value) {
	// 		return 'Current value: ' + value;
	// 	}
	// });

	// $('#simple_slider').change(function(){
	// 	var v = $(this).val();
	// 	alert(v)
	// });



});

/*-------------Image Uploading---------------------*/

jQuery(function() {
	$('#multiple_files').fileupload();
});

jQuery(function() {
	$('#primary_image_field').fileupload();
});





