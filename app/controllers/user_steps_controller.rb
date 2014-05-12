class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :personal,:location,:skill,:work_hours

	before_action :authenticate_user!

	def show
		@user = current_user
		@user.build_location
		@user.work_hours.build
		case step
		    when :skill
		      skip_step if @user.employer?
		    end
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
		when :skill
			@user.update_attributes(tag_params)
			render_wizard @user
		else
			@user.update_attributes(work_hours_params)
			render_wizard @user

		end
	end

	def tags 
		
		     @tag = Certification.all
		 respond_to do |format|
			format.json{ render :json =>@tag.where("title like ?","%#{params[:q]}%") }
		end
	end
	def state_response
		state = params[:value]
		@states = COUNTRIES_STATES[state]
		respond_to do |format|
			format.js
		end
	end

	private
	
	def user_params
		params.require(:user).permit(:company_name,:first_name,:last_name,:phone_primary,:phone_secondary,:birth_year,:gender,:criminal_convictions,:drivers_licence_class,:drivers_licence,:has_vehicle,:car_pool,:avatar)
	end

	def location_params
		params.require(:user).permit(location_attributes: [:address,:city,:zip,:country,:state,:time_zone])
	end
	
	def tag_params
		params.require(:user).permit(:tag_list,:certificate_list)
	end
	def work_hours_params
		params.require(:user).permit(work_hours_attributes: [:day_of_week, :start_time, :end_time])
	end
end
