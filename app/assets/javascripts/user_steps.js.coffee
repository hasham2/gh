#========Start===================Workhour_with_default_hours=============================
jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
 

#===========Start=====================Jquery_file_uplaod=====================================
jQuery ->
  $('#user_photos_attributes_0_image').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#user_photos_attributes_0_image').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')




#=======Start=================Enrollment step industry manipulation===================================
$(document).ready ->
  $("#user_employer_attributes_industry").change ->
    other = $("#user_employer_attributes_industry").val()
    if other is "others"
      $("#user_employer_attributes_other_industry").removeAttr "disabled"
    else
      $("#user_employer_attributes_other_industry").val ""
      $("#user_employer_attributes_other_industry").attr "disabled", true
    return

  return

#========Start================Workhour_with_standard_hours_and day ====================================
jQuery ->
  $("form").on "click", ".add_standard_fields", (event) ->
    i = 1

    while i < 7
      regexp = undefined
      time = undefined
      time = new Date().getTime()
      regexp = new RegExp($(this).data("id"), "g")
      
      # alert(time);
      # var a = $(this);
      # alert(a.day_of_week);
      $("a.add_fields").before $(this).data("fields").replace(regexp, time)
      switch i
        when 1
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "m"
        when 2
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "t"
        when 3
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "w"
        when 4
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "th"
        when 5
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "f"
        when 6
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "s"
        when 7
          $("#user_work_hours_attributes_" + time + "_day_of_week").val "su"
      i++
    
    # $('#user_work_hours_attributes_'+time+'_day_of_week').val('m');
    # country = $('.day_of_week').val('m');
    # alert(country);
    event.preventDefault()

  return


#===============Show states if Country is selected(In Enrollments)=============
$(document).ready ->
  
  #--------For Edit Mode-------------------------------
  selected_country = $("#user_location_attributes_country").val()
  if selected_country
    id = "user_location_attributes_country"
    populate_second_select id
    $(".state_group").attr "style", "display:block"
  
  #--------For Create Mode-------------------------------
  $("#user_location_attributes_country").change ->
    country = $("#user_location_attributes_country").val()
    if country
      $(".state_group").attr "style", "display:block"
    else
      $(".state_group").attr "style", "display:none"
    return

  return
