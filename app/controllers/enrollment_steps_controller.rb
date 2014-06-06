class EnrollmentStepsController < ApplicationController
  
  include Wicked::Wizard
  steps :enrollment_contact_information, :enrollment_detail, :enrollment_availabilty, :enrollment_images_attachments
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def show
  	@user = current_user
  	case step
    when :enrollment_contact_information
      @s = 1
    if @user.location ==nil
      @user.build_location
    else
     @user.location
    end
    when :enrollment_detail
       @s = 2
    if @user.role == "employer" and @user.employer ==nil
       @user.build_employer
    else 
      @user.employer
    end
    when :enrollment_availabilty
       @s=3
    if @user.work_hours.empty?
      @user.work_hours.build
    end
    when :enrollment_images_attachments
       @s = 4 

          @primary_photo = @user.photos.where(:is_primary => true)
          if  @user.photos.empty?
             @user.photos.build
           else
             @photos = @user.photos.where(:is_primary => nil)
           end
    end
    
 
  	render_wizard
  end
  def update
  	@user = current_user
  	case step
  	when :enrollment_contact_information
  		@user.update_attributes(user_params)
  		render_wizard @user
  	when :enrollment_detail
  		@user.update_attributes(user_params)
  		render_wizard @user
  	when :enrollment_availabilty
  		@user.update_attributes(user_params)
  		render_wizard @user
    else
      # binding.pry 
    @old_primary_photo = @user.photos.where(:is_primary => true)    
         @old_primary_photo.each do |p|
           p.update_attributes(:is_primary=>nil) 
         end    
         @new_image = params[:user][:photos_attributes]["0"][:image]
         @is_primary = params[:user][:photos_attributes]["0"][:is_primary]

       @user.photos.create(:is_primary=>@is_primary,:image=>@new_image)
         unless request.xhr?     
         render_wizard @user
          end
       @primary_photo = @user.photos.where(:is_primary => true)
       # binding.pry 
        respond_to do |format|
        format.js
    end

  end

end

  def add_photo
    @user = current_user
    @multiple_images = params[:photo][:image]     
    @multiple_images.each { |i|
    @user.photos.create(image: i)
    }
    @photo = @user.photos.last
    respond_to do |format|
      format.js
    end
  end
  
    def delete_photo
      @user = current_user
      @photo = @user.photos.find(params[:value])
      @photo.destroy
      @photos = @user.photos.where(:is_primary => nil)
      respond_to do |format|
        format.js
     end
  end

  def make_primary_photo
    @user = current_user
    @all_photos = @user.photos.all
    # make all photos unprimary
    @all_photos.each do |p|
    p.update_attributes(:is_primary=>nil) 
    end 
    # make unique primary photo
    @make_primary_photo = @user.photos.find(params[:value])
    @make_primary_photo.update_attributes(:is_primary=>true)
    # primary photo
    @primary_photo = @user.photos.where(:is_primary => true)
    #additional photos
    @photos = @user.photos.where(:is_primary => nil)
    
    respond_to do |format|
      format.js
    end 
  end
  def save_photo_caption
  @user = current_user
  @photo = @user.photos.find(params[:photo_id])
  @photo.update_attributes(:caption=>params[:photo_caption])

  end
  def tags 
    
    @tag = Certification.all
    respond_to do |format|
      format.json{ render :json =>@tag.where("title like ?","%#{params[:q]}%") }
    end
  end
  def state_response
    country = params[:value]
    @states = COUNTRIES_STATES[country]
    if current_user.location.present?
      @selected_state = current_user.location.state
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def finish_wizard_path
    current_user.update_attributes(:enrollment_complete=>true)
    flash[:notice]= 'Enrollment completed successfully'
    root_path
    # redirect_to root_path,notice:'enrollment completed successfully'
  end

  def user_params
    params.require(:user).permit!
  end
  # def user_params
  #   params.require(:user).permit(:company_name,
  #                                 :first_name,
  #                                 :last_name,
  #                                 :phone_primary,
  #                                 :phone_secondary,
  #                                 :birth_year,
  #                                 :gender,
  #                                 :criminal_convictions,
  #                                 :drivers_licence_class,
  #                                 :drivers_licence,
  #                                 :has_vehicle,
  #                                 :car_pool,:avatar,
  #                                 :business_activity_list,
  #                                 :tag_list, 
  #                                 :certificate_list,
  #                                 :credit_score,
  #                                 employer_attributes: [:business_name,
  #                                 :industry,
  #                                 :phone,
  #                                 :website,
  #                                 :description,
  #                                 :formation_year,
  #                                 :additional_information],
  #                                 location_attributes: [
  #                                 :address,
  #                                 :second_address,
  #                                 :city,:zip,:country,
  #                                 :state,
  #                                 :time_zone],
  #                                 work_hours_attributes: [
  #                                 :day_of_week,
  #                                 :start_time,
  #                                 :end_time])
  #end
end
