class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications, :payments

	def show
		@user = current_user

		@job = @user.jobs.build
		@job.build_location
		@job.photos.build
        case step
        when :candidate_prioritization
        5.times{@job.metrics.build}
        end
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
		# binding.pry
		params.require(:job).permit(metrics_attributes:[:metric_type_id, :value,:_destroy])
	end

	def images_params
		 # binding.pry
		params.require(:job).permit(photos_attributes:[:caption, :is_primary, :image])
	end

end
