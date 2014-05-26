class EnrollmentStepsController < ApplicationController
  
  include Wicked::Wizard
  steps :enrollment_contact_information, :enrollment_detail, :enrollment_availabilty, :enrollment_images_attachments

  def show
  	@user = current_user
  	@user.build_location
  	@user.work_hours.build
  	@user.build_employer
  	case step
  	when :skill
  		skip_step if @user.employer?
  	end
  	render_wizard
  end
  def update
  	@user = current_user
  	case step
  	when :enrollment_contact_information
  		@user.update_attributes(user_params)          	 
  		render_wizard @user
  	when :enrollment_detail
  		@user.update_attributes(tag_params)
  		render_wizard @user
  	else
  		@user.update_attributes(work_hours_params)
  		render_wizard @user

  	end
  end

end
