class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications

	def show
		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
     case step      
     when :job_details	 

     when :candidate_prioritization
     	4.times{@job.metrics.build}	
     when :images 
      
     when :education_and_certifications
     end
	   render_wizard
	end

	def update

		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
	   case step
	   when :job_details
	   @user.update_attributes(job_details_params)
	   session[:job_id]=@user.jobs.last.id
	   render_wizard @user
	   when :candidate_prioritization
	   @job.assign_attributes(candidate_prioritization_params)
	   render_wizard @job
	   when :images
	   @job.update_attributes(images_params)	  	
	   render_wizard @job
	   when :education_and_certifications
	   @job.update_attributes(education_and_certifications_params)
	   render_wizard @job
	   	# session[:job_id] = nil
	   end
	end

	def state_response
		state = params[:value]
		@states = COUNTRIES_STATES[state]
		respond_to do |format|
			format.js
		end
	end

	def add_certification
	  @certification = Certification.new(:title => params[:value])
	  respond_to do |format|
	    if @certification.save
	    	format.js 
	    	# format.json   {render json: @certification }
	    end
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

	def education_and_certifications_params
		params.require(:job).permit!
	end

end