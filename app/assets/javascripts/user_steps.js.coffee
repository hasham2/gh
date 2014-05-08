$ ->
  $('select#user_location_attributes_country').change (event) ->
    select_wrapper = $('#order_state_code_wrapper')

    $('select', select_wrapper).attr('disabled', true)

    country_code = $(this).val()

    url = "/user_steps/subregion_options?parent_region=#{country_code}"
    select_wrapper.load(url)
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