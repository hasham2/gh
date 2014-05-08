class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :personal,:location,:skill,:more

	before_action :authenticate_user!

	def show
		@user = current_user
		@user.build_location
		country_states_all
        render_wizard

	end
	def update
		@user = current_user
		case step
	    when :personal
	       @user.update_attributes(user_params)          	 
	       render_wizard @user
	    when :location
	      @user.update_attributes(location_params)
	       render_wizard @user
	   else
	   	@user.update_attributes(tag_params)
	   	render_wizard @user

	  end
	end

	def tags 
		
		@tag = Cetification.all
	  respond_to do |format|
	  
	    format.json{ render :json =>@tag }
	  end
	end
	def state_response
		@states = COUNTRIES_STATES[state]
		respond_to do |format|
		  format.js
		end
	end

	private
	
  def user_params
		params.require(:user).permit(:company_name,:first_name,:last_name,:phone_primary,:phone_secondary,:birth_year,:gender,:criminal_convictions,:drivers_licence_class,:drivers_licence,:has_vehicle,:car_pool)
	end

	def location_params
	  params.require(:user).permit(location_attributes: [:address,:city,:zip,:time_zone,:state])
	end
	
  def tag_params
		params.require(:user).permit(:tag_list,:certificate_list)
	end
end
