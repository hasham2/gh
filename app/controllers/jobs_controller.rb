class JobsController < ApplicationController
	before_action :is_employer

	def index
		@jobs = current_user.jobs.all.order(:id)
	end

	def new
		@job = Job.new
		@user = current_user
		@job = @user.jobs.build
	end

	def create
		@user = current_user
		@job = @user.jobs.build
		if @job.save
			session[:job_id] = @job.id
			redirect_to job_steps_path
		end
	end

	def show
		@employer_job_id = params[:employer_job_id]
		@job = Job.find(params[:id])
	end

	def edit
		@job = Job.find(params[:id])
		session[:job_id] = @job.id
		redirect_to job_steps_path	
	end

	def destroy
		@job = Job.find(params[:id])
		if @job.destroy
			redirect_to jobs_path, :notice=>'Job Deleted'
		end
	end

	def search

	end

	private
	
	def is_employer
		unless current_user.role == 'employer'
			flash[:error] = "Access Dinied"
			redirect_to root_path
		end
	end
	
end
