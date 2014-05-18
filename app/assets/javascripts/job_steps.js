

$(document).ready(function(){
	var address=""
	var city=""
	var country=""
	var state=""

	$('#job_location_attributes_address').change(function(){
		 address = $('#job_location_attributes_address').val();
		 address = address+","
		$('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('#job_location_attributes_city').change(function(){
		 city = $('#job_location_attributes_city').val();
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


});


