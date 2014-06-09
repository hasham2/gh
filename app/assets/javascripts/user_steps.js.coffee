#========Start===================Workhour_with_default_hours=============================


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
