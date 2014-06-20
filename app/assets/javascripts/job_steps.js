
/*---------Showing address on job_details page------------Start--*/
$(document).ready(function(){
	var address=""
	var second_address=""
	var city=""
	var country=""
	var state=""
	var zip_postal_code=""

	$('.address_field').change(function(){
		  address = $('.address_field').val();
		 address = address+","
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
		if (zip_postal_code !=""){
				if(country =='Canada'){
					$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
				}else{
					$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
				}
			
		}
		

	});

	$('.second_address_field').change(function(){
		  second_address = $('.second_address_field').val();
		 second_address = second_address+","
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
		  if (zip_postal_code !=""){
		  		if(country =='Canada'){
		  			$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
		  		}else{
		  			$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
		  		}
		  	
		  }
	});

	$('.city_field').change(function(){
		 city = $('.city_field').val();
		 city = city+","
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
			if (zip_postal_code !=""){
					if(country =='Canada'){
						$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
					}else{
						$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
					}
				
			}
	});

	$('#job_location_attributes_country').change(function(){
		 country = $('#job_location_attributes_country').val();
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
			if (zip_postal_code !=""){
					if(country =='Canada'){
						$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
					}else{
						$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
					}
				
			}
	});

	$('#job_location_attributes_state').change(function(){
		 state = $('#job_location_attributes_state').val();
		 state = state+","
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
			if (zip_postal_code !=""){
					if(country =='Canada'){
						$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
					}else{
						$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
					}
				
			}
	});

	$('.zip_code_field').change(function(){
		 zip_postal_code = $('.zip_code_field').val();
		$('#address_city').text(address+" "+second_address+" "+city);
		$('#state_country').text(state+" "+country);
			if (zip_postal_code !=""){
					if(country =='Canada'){
						$('#zip_postal_code').text("Postal Code: "+zip_postal_code);
					}else{
						$('#zip_postal_code').text("Zip Code: "+zip_postal_code);
					}
				
			}
	});

	/*=======Add Button functionality of Education and Certifications========*/
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

	/*=======Delete Button functionality of Education and Certifications========*/
	var current_certification_id =""

	$('.delete_certification_value').change(function(){
		current_certification_id =	$('.delete_certification_value').find('option:selected').val();
	});

	$('#delete_certification').click(function(){		
		if (!current_certification_id){

			alert('Please Selelct some Value');
		}
		else if (current_certification_id){		
			$.ajax({
			   method:'post',
			   url:'./delete_certification',
			   data: {value:current_certification_id}
			 });
		/*Making the following variable empty to avoid reuse of the containing value*/
		current_certification_id =""
		}	

	});

	/*=======Add Button functionality of Job Requiremets========*/
	$('#add_requirement').click(function(){
		var new_requirement =	$('#add_requirement_value').val();
		if (new_requirement == ""){

			alert('Please Enter some Value')
		}else{
		// alert(new_requirement);
			$.ajax({
			   method:'post',
			   url:'./add_requirement',
			   data: {value:new_requirement}
			 });

			$('#add_requirement_value').val("");
		}	

	});

	/*=======Delete Button functionality of Job Requirements========*/
	var current_requirement_id =""

	$('.delete_requirement_value').change(function(){
		current_requirement_id =	$('.delete_requirement_value').find('option:selected').val();
	});

	$('#delete_requirement').click(function(){		
		if (!current_requirement_id){

			alert('Please Selelct some Value');
		}
		else if (current_requirement_id){
			$.ajax({
			   method:'post',
			   url:'./delete_requirement',
			   data: {value:current_requirement_id}
			 });
			/*Making the following variable empty to avoid reuse of the containing value*/
			current_requirement_id =""
		}	

	});

	/*===Make by default primary image============*/
	$('a#next_step_from_images').click(function(){
		$.ajax({
			method:'post',
			url:'./make_by_default_primary_image'

		});
	});

});

/*================Show states if Country is selected(In job_steps)=====================*/
$(document).ready(function(){
	/*--------For Edit Mode-------------------------------*/
	var selected_country = $('#job_location_attributes_country').val();
		if(selected_country){
			var id = 'job_location_attributes_country'
			populate_second_select(id)	
			$('.state_group').attr('style','display:block');
		}
 
	/*--------For Create Mode-------------------------------*/
	$('#job_location_attributes_country').change(function(){
	 country = $('#job_location_attributes_country').val();
	 if (country){
	 	$('.state_group').attr('style','display:block');		 	
		}else{
		$('.state_group').attr('style','display:none');	
		}
	});
});

/*==================Image Uploading=====================*/

jQuery(function() {
	$('#multiple_files').fileupload();
});

jQuery(function() {
	$('#primary_image_field').fileupload();
});



/*=========== Is Firmed Field Functionalty Added===========*/
$(document).ready(function(){
	/*================Edit Mode====================*/
	var value = $('#desired_wage_is_firm').is(':checked')
	if(value){
		$('#max_wage').attr('disabled',true);
	}
	/*=====================Create Mode=============================*/
	$('#desired_wage_is_firm').click(function(){
		var value = $(this).is(':checked')
		if(value == true){
			// alert(value)
			var desired_wage = $('#desired_wage').val();
			$('#max_wage').val(desired_wage)
			$('#max_wage').attr('disabled',true);
		}else if (value == false){
			var desired_wage = $('#desired_wage').val();
			$('#max_wage').val(desired_wage).attr('disabled',false);

		}
	});
});

/*=======================Job Category Functionality Added========================*/
$(document).ready(function(){
	/*-----------Edit Mode------------*/
	var value = $('#job_category').val();
	if (value == 'Temporary' || value == 'Contract'){
		$('#work_duration').attr('disabled',false);
	}
	else{
		$('#work_duration').attr('disabled',true);
	}

	/*-----------Create Mode------------*/
	$('#job_category').change(function(){
		var value = $(this).val();
		if (value == 'Temporary' || value == 'Contract'){
			$('#work_duration').attr('disabled',false);
		}
		else{
			$('#work_duration').attr('disabled',true);
		}
	});

});

/*===================Set Employer's Address Functionality Added=================*/

$(document).ready(function(){
	$('#set_employer_address').click(function(){
		$.ajax({
			method:'post',
			url:'./set_employer_address'

		});
	});
});


/*===============simple slider Functionality===================*/

$(document).ready(function(){
	/*Displaying correct Enable Number*/
	for(var i = 0; i <=4 ; i++){
		var e = i + 1;
		$('#job_metrics_attributes_'+i+'__destroy').siblings('span').text('Enable '+e);
	}

	/*Auto selecting Checkbox on changing the slider */
	$('.simple_slider').change(function(){
		var current_slider_id = $(this).attr('id').split('_')[3];
			/*making Checkbox true on changing the slider */
		  $('#job_metrics_attributes_'+current_slider_id+'__destroy').prop('checked', true);
		  $('#job_metrics_attributes_'+current_slider_id+'_metric_type_id').prop('required',true);

	});

	/*Settig Checkbox state in Edit Mode*/
	for(var i = 0; i <=4 ; i++){
		var current_slider_value = $('#job_metrics_attributes_'+i+'_value').val();
		var metric_type_value = $('#job_metrics_attributes_'+i+'_metric_type_id').find('option:selected').text();
			if(current_slider_value >1 || metric_type_value !='Metric Type' ){
				$('#job_metrics_attributes_'+i+'__destroy').prop('checked', true);
				$('#job_metrics_attributes_'+i+'_metric_type_id').prop('required',true);
			}
	}

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

/*===Make sure that Every Drop Down selects Unique value===*/
$(document).ready(function() {

		$('.select_metric_type').change(function(){
				/*---Get ID of currently changed Dropdown ---*/
				var select_box_id = $(this).attr('id').split('_')[3];
				/*---Count the number of elements in the Dropdown---*/
				var select_box_size = $('.select_metric_type').size(); 

				/*Disabled the seleted options in the further Dropdowns*/
				make_options_disable(select_box_id, select_box_size);
				/*--Enabled the options if they are not being used now--*/
				make_options_enable(select_box_id, select_box_size);

		});


		function make_options_enable(select_box_id, select_box_size){

			var selected_option_of_select_box_id_0 = $('#job_metrics_attributes_0_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_1 = $('#job_metrics_attributes_1_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_2 = $('#job_metrics_attributes_2_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_3 = $('#job_metrics_attributes_3_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_4 = $('#job_metrics_attributes_4_metric_type_id').find('option:selected').val();



			for(var i = 0; i <=select_box_size ; i++){	
					// alert(i)
					if (i == selected_option_of_select_box_id_0 || i == selected_option_of_select_box_id_1 || i == selected_option_of_select_box_id_2 || i == selected_option_of_select_box_id_3 || i == selected_option_of_select_box_id_4 ){

					}else{
						 $('.select_metric_type').find('option[value ='+i+']').attr('disabled',false);
					}		 
				

			}

		}
	    
		function make_options_disable(select_box_id, select_box_size){

			var selected_option_of_select_box_id_0 = $('#job_metrics_attributes_0_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_1 = $('#job_metrics_attributes_1_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_2 = $('#job_metrics_attributes_2_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_3 = $('#job_metrics_attributes_3_metric_type_id').find('option:selected').val();
			var selected_option_of_select_box_id_4 = $('#job_metrics_attributes_4_metric_type_id').find('option:selected').val();

			for(var i = 0; i <=select_box_size ; i++){	
					// alert(i)
					if (i == selected_option_of_select_box_id_0){
						$('.select_metric_type').find('option[value ='+i+']').attr('disabled',true);
					} 
					else if (i == selected_option_of_select_box_id_1){
						$('.select_metric_type').find('option[value ='+i+']').attr('disabled',true);
					}
					else if (i == selected_option_of_select_box_id_2){
						$('.select_metric_type').find('option[value ='+i+']').attr('disabled',true);
					}
					else if (i == selected_option_of_select_box_id_3){
						$('.select_metric_type').find('option[value ='+i+']').attr('disabled',true);
					}
					else if (i == selected_option_of_select_box_id_4){
						$('.select_metric_type').find('option[value ='+i+']').attr('disabled',true);
					}
			}

			/*-----Enable the selected option only in the current Dropdown-----*/
			for (var i = 0; i <=4; i++) {
				if (i == select_box_id){
						$('#job_metrics_attributes_'+i+'_metric_type_id').find('option:selected').attr('disabled',false);
				}

			}

		}

});



