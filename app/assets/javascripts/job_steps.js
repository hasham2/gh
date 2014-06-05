
/*---------Showing address on job_details page------------Start--*/
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

	$('#job_location_attributes_country').change(function(){
		 country = $('#job_location_attributes_country').val();
		 $('#address_city').text(address+" "+city);
		 $('#state_country').text(state+" "+country);
	});

	$('#job_location_attributes_state').change(function(){
		 state = $('#job_location_attributes_state').val();
		 state = state+","
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


	$('#next_step_from_images').click(function(){
		// alert('Atif')
		$.ajax({
			method:'post',
			url:'./make_by_default_primary_image'

		});
	});

});

/*-----------Show states if Country is selected--------------*/
$(document).ready(function(){

 	 state = $('#job_location_attributes_state').val();
 	if(state){
 		$('.state_group').attr('style','display:inline-block');	
 	}

	$('#job_location_attributes_country').change(function(){
	 country = $('#job_location_attributes_country').val();


	 if (country){
	 	$('.state_group').attr('style','display:inline-block');		 	
	}else{
		$('.state_group').attr('style','display:none');
	}

	});
});

/*========================Enrollment step industry manipulation===================================*/

$(document).ready(function(){

 	//  state = $('#job_location_attributes_state').val();
 	// if(state){
 	// 	$('.state_group').attr('style','display:inline-block');	
 	// }

	$('#user_employer_attributes_industry').change(function(){
	 var other = $('#user_employer_attributes_industry').val();
	 if (other=="others"){
	 	$('#user_employer_attributes_other_industry').removeAttr("disabled");
	}else{
		$('#user_employer_attributes_other_industry').val("");	
		 $('#user_employer_attributes_other_industry').attr('disabled',true);
	}

	});
});





/*============================================================*/
/*-------------Image Uploading---------------------*/

jQuery(function() {
	$('#multiple_files').fileupload();
});

jQuery(function() {
	$('#primary_image_field').fileupload();
});





