class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications, :payments

	def show
		@user = current_user
		@job  = @user.jobs.build
		@job.build_location

         case step
         when :candidate_prioritization
         5.times{@job.metrics.build}
         when :images  
         @job.photos.build
     	 when :education_and_certifications
     	 	@job.requirements.build
     	 	@job.certifications.build
         end
	  	 render_wizard
	end

	def update
  		@user = current_user
  		case step
  		when :job_details
  		@user.update_attributes(job_details_params)
  		render_wizard @user
  		when :candidate_prioritization
  		@user.update_attributes(candidate_prioritization_params)
  		render_wizard @user
  		when :images
  		@user.update_attributes(images_params)	  	
  		render_wizard @user
  		when :education_and_certifications
	 	@user.update_attributes(education_and_certifications_params)	  	
  		render_wizard @user

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

	def state_response
		state = params[:value]
		@states = COUNTRIES_STATES[state]
		respond_to do |format|
			format.js
		end
	end


	def job_details_params	
		params.require(:user).permit(jobs_attributes:[:user_id,:title, :hours_per_day, :work_duration, :desired_wage, :max_wage, :desired_wage_is_firm, :start_date, :listing_expires_on, :description, location_attributes: [:address,:city,:zip,:country,:state,:time_zone]])
	end

	def candidate_prioritization_params
		params.require(:user).permit!
	end

	def images_params
		# binding.pry
		params.require(:user).permit!
	end

	def education_and_certifications_params
		   params.require(:user).permit(jobs_attributes:[:requirement_attributes[:name  => [] ]])
	end
end

	# def images_params
	# 	params.require(:job).permit(photos_attributes:[:caption, :is_primary, :image])
	# end
