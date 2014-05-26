

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

	$('#user_jobs_attributes_0_location_attributes_state').change(function(){
		 state = $('#user_jobs_attributes_0_location_attributes_state').val();
		 state = state+","
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('#user_jobs_attributes_0_location_attributes_country').change(function(){
		 country = $('#user_jobs_attributes_0_location_attributes_country').val();
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});


	$('#add_certification').click(function(){
		var new_certification =	$('#add_certification_value').val();
		// alert(new_certification);
		$.ajax({
		   method:'post',
		   url:'./add_certification',
		   data: {value:new_certification}
		 });

		$('#add_certification_value').val("");

	});

});



jQuery(function() {
	$('#job_photos_attributes_0_image').fileupload();
});





