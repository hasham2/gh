class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications, :payments

	def show
		@user = current_user

		@job = @user.jobs.build
		@job.build_location
		@job.metrics.build
		@job.photos.build
		@job.requirements.build
		@job.certifications.build
	  	render_wizard
	end

	def update
	  @user = current_user
	  @job = @user.jobs.build
	  case step
	  when :job_details
	  @job.update_attributes(job_details_params)
	  render_wizard @job
	  when :candidate_prioritization
	  @job.update_attributes(candidate_prioritization_params)
	  render_wizard @job
	  when :images
	  @job.update_attributes(images_params)	  	
	  render_wizard @job
	  when :education_and_certifications
 		 	
		 # @requirements = params[:job][:requirements_attributes]["0"][:name]
		 #  @requirements.each do |req|
		 #  	binding.pry
		 # 	@job.update_attributes(:requirements_attributes=>{:name=>req})	  
		 # end 

		 @job.update_attributes(education_and_certifications_params)	  	
	  	render_wizard @job 	

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
		params.require(:job).permit(:title, :hours_per_day, :work_duration, :desired_wage, :max_wage, :desired_wage_is_firm, :start_date, :listing_expires_on, :description, location_attributes: [:address,:city,:zip,:country,:state,:time_zone])
	end

	def candidate_prioritization_params
		params.require(:job).permit(metrics_attributes:[:metric_type_id, :value])
	end

	def images_params
		params.require(:job).permit(photos_attributes:[:caption, :is_primary, :image])
	end

	def education_and_certifications_params
		  params.require(:job).permit(:requirement_ids => [], :certification_ids => [])
	end
end
