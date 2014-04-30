class Users::ConfirmationsController < Devise::ConfirmationsController
  
  protected
  
  def after_confirmation_path_for(resource_name, resource)
    if resource.employer?
      edit_user_registration_path
    else
    	user_steps_path
      # new_location_path
    end
  end
  
end
