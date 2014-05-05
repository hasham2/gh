class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :personal,:location,:more

	before_action :authenticate_user!

	def show
		@user = current_user
		@user.build_location
    render_wizard
	end
	def update
		@user = current_user
		case step
	    when :personal
	      @user = current_user
	      binding.pry
	    	 @user.update_attributes(user_params)          	 
	       render_wizard @user
	    else
	      @user.update_attributes(location_params)
	      render_wizard @location
	  end
	end
	def subregion_options
	  render partial: 'subregion_select'
	end
	private
	def user_params
		params.require(:user).permit(:company_name,:first_name,:last_name,:phone_primary,:phone_secondary,:birth_year,:gender,:criminal_convictions,:driver_licence,:licence_class,:has_vehicle,:car_pool,:tag_list)

	end
	def location_params
	  params.require(:user).permit(location_attributes: [:address,:city,:state,:zip,:country,:time_zone])
	end

end


  
   
   