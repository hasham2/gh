class JobsController < ApplicationController

	def index
		
	end

	def new
	@job = Job.new
	@user = current_user
	@job = @user.jobs.build

	
	end

	def create
		 @user = current_user
		 @job = @user.jobs.build()
		 @job.build_location
		 @job.metrics.build
		 @job.photos.build
		 @job.requirements.build
		 @job.certifications.build
	    if @job.save
	    	session[:job_id] = @job.id
	    	redirect_to job_steps_path
	    end
	end
	
end
