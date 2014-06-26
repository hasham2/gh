class JobStepsController < ApplicationController

	include Wicked::Wizard
    before_filter :authenticate_user!
    before_action :check_enrollment
    before_action :check_job_exit
    

	steps :job_details, :candidate_prioritization, :images, :education_and_certifications

	def show
		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)

     	@current_user_jobs = @user.jobs.count
     case step      
     when :job_details
     	@stp = 1
     	if  current_user.employer == nil 
			@business_name = ''
		else
			@business_name = current_user.employer.business_name
     	end 
     	
		if @job.location == nil
			@job.build_location
		else
		@job.location
		end
     when :candidate_prioritization
     	@stp = 2
     	# if @job.metrics.empty? 
     	#5.times{@job.metrics.build}
     	 5.times{@job.metrics.build} if @job.metrics.empty?

     	# else
     	# 	if @job.metrics.count < 5
     	# 	@m = 5 - @job.metrics.count
     	# 	@m.times{@job.metrics.build}
     	# 	end
     	 
     	# end	
     when :images
     	@stp = 3
     	@user_primary_photo = current_user.photos.where(:is_primary=>true)
     	@primary_photo = @job.photos.where(:is_primary => true)
     	@existing_photos = Photo.where(:photoable_id != @job_id && :photoable_type=>'Job'  )

     		 if  @job.photos.empty?
      		 @job.photos.build
      	 else
     	   @photos = @job.photos.where(:is_primary => nil)
      	 end

     when :education_and_certifications
     	@stp = 4
     	@job.requirements.build
     	@job.certifications.build
     	@employer_id = current_user.employer.id

     	# getting requirements of current employer and universal requirements
     	@universal_and_employer_requirements = Requirement.where({:employer_id=>[nil,@employer_id]})
     	# getting requirements of current employer only
     	@employer_requirements = Requirement.where(:employer_id=>@employer_id)

     	# getting certifications of current employer and universal certifications
     	@universal_and_employer_certifications = Certification.where({:employer_id=>[nil,@employer_id]})
     	# getting certifications of current employer only
     	@employer_certifications = Certification.where(:employer_id=>@employer_id)
     end
	   render_wizard
	end

	def update

		@user = current_user
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
	   case step
	   when :job_details
	   	month = params[:job][:start_date].split('/')[0].to_i
	   	day = params[:job][:start_date].split('/')[1].to_i
	   	year = params[:job][:start_date].split('/')[2].to_i
	   	date = Date.new(year,month,day)
	   	params[:job][:start_date] = date

	   	date = params[:job][:listing_expires_on].split(' ')[0]
	   	date_month = date.split('/')[0].to_i
	   	date_day   = date.split('/')[1].to_i
	   	date_year  = date.split('/')[2].to_i
   	  time = params[:job][:listing_expires_on].split(' ')[1]
   	  time_hour = time.split(':')[0].to_i
   	  time_minut= time.split(':')[1].to_i
	   	# date = DateTime.new(date_year, date_month, date_day, time_hour, time_minut, time_second,00)
	   	date = DateTime.new(date_year, date_month, date_day,  time_hour,  time_minut,  0)
	   	params[:job][:listing_expires_on] =  date.strftime("%Y/%m/%d %I:%M %p")
	   @job.update_attributes(job_details_params)
	   render_wizard @job
	   when :candidate_prioritization
	   	# binding.pry 
	   @job.update_attributes(candidate_prioritization_params)
	   render_wizard @job
	   when :images
		@old_primary_photo = @job.photos.where(:is_primary => true)		
	   	@old_primary_photo.each do |p|
	   		p.update_attributes(:is_primary=>nil)	
	   	end	   
	   	@new_image = params[:job][:photos_attributes]["0"][:image]
	   	@is_primary = params[:job][:photos_attributes]["0"][:is_primary]

	    @job.photos.create(:is_primary=>@is_primary,:image=>@new_image)
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
		country = params[:value]
		@states = COUNTRIES_STATES[country]
		# To find the selected state
		@job_id = session[:job_id]
		@job = Job.find(@job_id)
		if @job.location.present?
			@selected_state = @job.location.state
		end
		# binding.pry
		respond_to do |format|
			format.js
		end
	end

	def add_certification
	  @employer_id = current_user.employer.id
	  @certification = Certification.new(:title => params[:value], :employer_id =>@employer_id)
	  respond_to do |format|
	    if @certification.save
	    	# getting certifications of current employer only
	    	@employer_certifications = Certification.where(:employer_id=>@employer_id)
	    	format.js 
	    	# format.json   {render json: @certification }
	    end
	  end
	end

	def delete_certification
		# binding.pry
		if params[:value]
			@certification = Certification.find(params[:value])

		   if @certification.present?
			  respond_to do |format|
			  	if @certification.destroy
			  		format.js
			  	end
			  end
			end
		end
	end

	def add_requirement
	  @employer_id = current_user.employer.id
	  @requirement = Requirement.new(:name => params[:value], :employer_id =>@employer_id)
	  respond_to do |format|
	    if @requirement.save
     		# getting requirements of current employer only
     		@employer_requirements = Requirement.where(:employer_id=>@employer_id)
	    	format.js 
	    	# format.json   {render json: @requirement }
	    end
	  end
	end

	def delete_requirement

		if params[:value]
		 	@requirement = Requirement.find(params[:value])

		   if @requirement.present?
			  respond_to do |format|
			  	if @requirement.destroy
			  		format.js
			  	end
			  end
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

	def delete_photo
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
     	@photo = @job.photos.find(params[:value])
     	@photo.destroy
     	@photos = @job.photos.where(:is_primary => nil)
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

	def save_photo_caption
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
     	@photo = @job.photos.find(params[:photo_id])
     	@photo.update_attributes(:caption=>params[:photo_caption])

	end

	def make_by_default_primary_image
		@job_id = session[:job_id]
     	@job = Job.find(@job_id)
		@primary_photo = @job.photos.where(:is_primary => true)

		unless @primary_photo.present?	
			@user_primary_photo = current_user.photos.where(:is_primary=>true).first
			@job.photos.create(:photoable_type=>"Job", :is_primary=>true,:image=>@user_primary_photo.image)
		end
		
	end

	def choose_existing_photo
		@job_id = session[:job_id]
    @job = Job.find(@job_id)
    @selected_photo = Photo.where(:id =>params[:value]).first
    @job.photos.create(:photoable_type=>"Job", :is_primary=>nil, :image=>@selected_photo.image)
		@photo = @job.photos.last
     	respond_to do |format|
     		format.js
     	end				
	end


	def set_employer_address
		# binding.pry
		if current_user.location.present?
			@employer_address = current_user.location

			if @employer_address.country.present?
			country = @employer_address.country
			@states = COUNTRIES_STATES[country]
		  end
		else
			@employer_address = nil
		end
	end

private
	def check_job_exit
		
		if session[:job_id]==nil
		 	redirect_to root_path ,:notice=>"Create job first "
		 end 
	end
	def job_details_params
		@desired_wage_is_firm = params[:job][:desired_wage_is_firm]
		if @desired_wage_is_firm == "true"
			@desired_wage = params[:job][:desired_wage]
			params[:job][:max_wage] = @desired_wage
		end

		 # params.require(:job).permit(:id,:title, :hours_per_day, :work_duration, :job_category, :desired_wage, :max_wage, :desired_wage_is_firm, :start_date, :listing_expires_on, :description,location_attributes: [:address,:second_address,:city,:zip,:country,:state,:time_zone,:approximate_address])
		 params.require(:job).permit!
	end

	def candidate_prioritization_params
		params.require(:job).permit!
	end

	def images_params
		params.require(:job).permit!
	end

	def education_and_certifications_params
		 # binding.pry
		params.require(:job).permit!
	end

end