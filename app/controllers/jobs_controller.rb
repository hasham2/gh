class JobsController < ApplicationController
  before_filter :authenticate_user!, :except => [:search, :show]
  before_filter :is_employer,  :except => [:search, :show,:make_primary_photo]
  autocomplete :certification, :name,:full => true,:column_name => 'title'


  def index
    @jobs = current_user.jobs.all.order(:id)
  end

  def new
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

    

    if @job.user && @job.user.employer
      #Business Name
      @business_name = @job.user.employer.business_name
      #Member Since
      @member_since = @job.user.created_at
      # Employer's Primary Image
      @user_primary_photo = @job.user.photos.where(:is_primary=>true)

      # Active Jobs of Employer
      @active_listings = @job.user.jobs.where(:active_job=>true).count
      # Total Jobs of Employer
      @total_listings = @job.user.jobs.count
      
    end


    # Total Views of a Job
    @counter = @job.views  
    @counter = @counter+1
    @job.update_attributes(:views=>@counter)


  end

  def edit
    @employer_job_id = params[:employer_job_id]
    
    @job = Job.find(params[:id])
    session[:job_id] = params[:id]
    
    if current_user.employer == nil 
      @business_name = ''
    else
      @business_name = current_user.employer.business_name
    end 

    if @job.location == nil
      @job.build_location
    else
      @job.location
    end

    if @job.metrics.empty? 
      5.times{@job.metrics.build}
    else
      if @job.metrics.count < 5
        @m = 5 - @job.metrics.count
        @m.times{@job.metrics.build}
      end
    end

    @user_primary_photo = current_user.photos.where(:is_primary=>true)
    @primary_photo = @job.photos.where(:is_primary => true)
    @existing_photos = Photo.where(:photoable_id != @job_id && :photoable_type=>'Job'  )
    if  @job.photos.empty?
      @job.photos.build
    else
      @photos = @job.photos.where(:is_primary => nil)
    end
    @employer_id = current_user.employer.id
    @universal_and_employer_requirements = Requirement.where({:employer_id=>[nil,@employer_id]})
    @counter = @job.views  
  end
  def update
   @job = Job.find(params[:id])

   if params[:job][:photos_attributes]
    @old_primary_photo = @job.photos.where(:is_primary => true)   
    @old_primary_photo.each do |p|
      p.update_attributes(:is_primary=>nil) 
    end   

    @new_image = params[:job][:photos_attributes]["0"][:image]
    @is_primary = params[:job][:photos_attributes]["0"][:is_primary]
    @job.photos.create(:is_primary=>@is_primary,:image=>@new_image)
    @primary_photo = @job.photos.where(:is_primary => true)
  end
else  
  @done = @job.update_attributes(job_params)
  if @done
    flash[:notice]="Job Successfully updated"
  else
    flash[:notice]="Unable to update"
  end

  respond_to do |format|
   format.html { redirect_to @job }
   format.js
 end
end
def destroy
  @job = Job.find(params[:id])
  if @job.destroy
    redirect_to jobs_path, :notice=>'Job Deleted'
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
      #-------------------------------------------------------------#

      @requirements = Requirement.where(:employer_id=>nil)
      @address = params['gmaps-input-address']
      if params[:max_distance].present?
        @max_distance = params[:max_distance]
      else
        @max_distance = 25
      end
      
      if params[:hourly_pay].present?
        @hourly_pay = params[:hourly_pay]
      else
        @hourly_pay = 0
      end  
      
      @fixed_price = params[:fixed_price]
      @max_days_listed = params[:max_days_listed]
      @earliest_start_date = params[:earliest_start_date]
      @job_level = params[:job_level]
      @req_ids = params[:req_ids]

      @certifications_and_requirements_vals = params[:certificate_vals]
      if @certifications_and_requirements_vals != nil
       @certifications_and_requirements_vals.reject! { |c| c.empty? }
     end

     if (@max_distance.present? ||  @hourly_pay.present? || @earliest_start_date.present? || @max_days_listed.present? || @job_level.present? || @req_ids.present? || @certifications_and_requirements_vals.present?)
      @jobs= Job.my_search(@max_distance, @address,@hourly_pay,@fixed_price ,@earliest_start_date, @max_days_listed, @job_level, @req_ids, @certifications_and_requirements_vals)

      if @jobs
        job_ids = Array.new
        @jobs.each do |j|
          job_ids<<j.id
        end
        @jobs = Job.where('id in (?)', job_ids)
        # @jobs=@jobs.paginate(:page => params[:page], :per_page => 2)
      end
    end    
    if request.xhr? 
      if @jobs
        @jobslist = @jobs.map do |j|
          {:id => j.id, :title => j.title ,:start_date=>j.start_date.try(:strftime, '%d %b %Y'),:hours_per_day=>j.hours_per_day,:max_wage=>j.max_wage,:desired_wage=>j.desired_wage,:work_duration=>j.work_duration, :lat => j.location.lat, :lng => j.location.lng }
        end
      end
        # json = @jobslist.to_json
        @jobs = @jobs.page(params[:page]).per(2) if @jobs
        respond_to do |format|
          format.js  {render json: @jobslist}
        # binding.pry
      end

    end 
    # @jobs = Job.all
  end


  def autocomplete_suggestion

    if params[:term]
      params[:term] = params[:term].downcase
      @requirements = Requirement.where('name LIKE ?', "%#{params[:term]}%")
      @certifications = Certification.where('title LIKE ?', "%#{params[:term]}%")
      if @certifications
        @certification_list = @certifications.map do |c|
          {:id => c.id, :name => c.title }
        end
      end
      if @requirements
        @requirement_list = @requirements.map do |r|
          {:id => r.id, :name => r.name }
        end
      end
      @req = @requirement_list.concat(@certification_list)
    end

    respond_to do |format|  
      format.json { render :json => @req}
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

    def save_photo_caption
      @job_id = session[:job_id]
      @job = Job.find(@job_id)
      @photo = @job.photos.find(params[:photo_id])
      @photo.update_attributes(:caption=>params[:photo_caption])

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
    
    private
    def job_params
      params.require(:job).permit!    
    end

    def is_employer
        unless current_user.role == 'employer'
          # flash[:error] = "Access Dinied"
          redirect_to root_path
        end
    end
  end
