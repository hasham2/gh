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
		@job = @user.jobs.build
    if @job.save
      session[:job_id] = @job.id
      redirect_to job_steps_path
    end
	end

  def search
    if params[:lat].blank? || params[:lng].blank?
      # Geocode the address
      resp = Geocoder.search("#{params['gmaps-input-address']}")
      @lat = resp.first.latitude rescue nil
      @lng = resp.first.longitude rescue nil
    else
      @lat = params[:lat]
      @lng = params[:lng]
    end
  end
end
