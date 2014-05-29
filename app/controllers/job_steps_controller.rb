class JobStepsController < ApplicationController

	include Wicked::Wizard
	steps :job_details, :candidate_prioritization, :images, :education_and_certifications

	def show
		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)

     	@current_user_jobs = @user.jobs.count
     case step      
     when :job_details
     	@stp = 1 
		if @job.location == nil
			@job.build_location
		else
		@job.location
		end
     when :candidate_prioritization
     	@stp = 2
     	if @job.metrics.empty? 
     	5.times{@job.metrics.build}
     	else
     		if @job.metrics.count < 5
     		@m = 5 - @job.metrics.count
     		@m.times{@job.metrics.build}
     		end
     	 
     	end	
     when :images
     	@stp = 3

     	@primary_photo = @job.photos.where(:is_primary => true)
     	if  @job.photos.empty?
      		 @job.photos.build
      	 else
     	   @photos = @job.photos.where(:is_primary => nil)
      	 end

     when :education_and_certifications
     	@stp = 4
     	@job.requirements.build
     	@job.certifications.build
     end
	   render_wizard
	end

	def update

		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
	   case step
	   when :job_details
	   @job.update_attributes(job_details_params)
	   session[:job_id]=@user.jobs.last.id
	   render_wizard @job
	   when :candidate_prioritization
	   @job.assign_attributes(candidate_prioritization_params)
	   render_wizard @job
	   when :images
		@primary_photo = @job.photos.where(:is_primary => true)		
		@primary_photo.each do |p|
			p.update_attributes(:is_primary=>nil)	
		end	
		  	
	   @job.update_attributes(images_params)
	   	unless request.xhr?	  	
	   	render_wizard @job
	   	end
     	@primary_photo = @job.photos.where(:is_primary => true)
       	respond_to do |format|
        	format.js
         end

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

	def add_photo
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)

     	@multiple_images = params[:photo][:image] 		
     	   @multiple_images.each { |i|
     	    @job.photos.create(image: i)
     	  }

     	@photo = @job.photos.last
       	respond_to do |format|
        	format.js
         end

	end

	def make_primary_photo
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)

     	@all_photos = @job.photos.all
		# make all photos unprimary
		@all_photos.each do |p|
			p.update_attributes(:is_primary=>nil)	
		end	
		# make unique primary photo
		@make_primary_photo = @job.photos.find(params[:value])
		@make_primary_photo.update_attributes(:is_primary=>true)
		# primary photo
		@primary_photo = @job.photos.where(:is_primary => true)
		#additional photos
		@photos = @job.photos.where(:is_primary => nil)
     	respond_to do |format|
     		format.js
     	end	
	end

	def job_details_params	
		params.require(:job).permit!#(jobs_attributes:[:user_id,:title, :hours_per_day, :work_duration, :desired_wage, :max_wage, :desired_wage_is_firm, :start_date, :listing_expires_on, :description,location_attributes: [:address,:city,:zip,:country,:state,:time_zone]])
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