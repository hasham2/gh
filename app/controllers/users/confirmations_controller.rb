class Users::ConfirmationsController < Devise::ConfirmationsController
  
  protected
  
  def after_confirmation_path_for(resource_name, resource)
    if resource.employer?
      edit_user_registration_path
    else
      new_location_path
    end
  end
  
end
