class EnrollmentStepsController < ApplicationController
  
  include Wicked::Wizard
  steps :enrollment_contact_information, :enrollment_detail, :enrollment_availabilty, :enrollment_images_attachments

  def show
  	render_wizard
  end

  def update
  end
end
