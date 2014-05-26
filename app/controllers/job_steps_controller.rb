class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications, :payments

	def show
		@user = current_user
		@met = @user.jobs.last
     case step      
     when :job_details	 
    
     	@job = @user.jobs.build
     	@job.build_location
     when :candidate_prioritization
     	5.times{@met.metrics.build}	
     when :images 
      @met.photos.build
      end
	   render_wizard
	end

	def update

	  @user = current_user
	  @met = @user.jobs.last
	   case step
	   when :job_details
	   @user.update_attributes(job_details_params)
	   session[:job_id]=@user.jobs.last.id
	   render_wizard @user
	   when :candidate_prioritization
	   @met.assign_attributes(candidate_prioritization_params)
	   render_wizard @met
	   when :images
	   @met.update_attributes(images_params)	  	
	   render_wizard @met
	   end
	end

	def state_response
		state = params[:value]
		@states = COUNTRIES_STATES[state]
		respond_to do |format|
			format.js
		end
	end




	def job_details_params	
		params.require(:user).permit!#(jobs_attributes:[:user_id,:title, :hours_per_day, :work_duration, :desired_wage, :max_wage, :desired_wage_is_firm, :start_date, :listing_expires_on, :description,location_attributes: [:address,:city,:zip,:country,:state,:time_zone]])
	end

	def candidate_prioritization_params
		params.require(:job).permit!
	end

	def images_params
		params.require(:job).permit!
	end

end