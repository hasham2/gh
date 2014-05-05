class CertificationsController < ApplicationController
  
  before_filter :authenticate_user!
  after_action :verify_authorized
  def index
   @certification = Certification.new
   @certifications = Certification.all
   authorize @certifications
  end
  
  def create
    @certification = Certification.new(certification_params)
   authorize @certification
    respond_to do |format|
      if @certification.save
        format.html { redirect_to certification_path, notice: 'User was successfully created.' }
        format.js   {}
      end
    end
  end
  

  def destroy
    @certification = Certification.find(params[:id])
      @certification.destroy
    flash[:success] = "certification deleted." 
      respond_to do |format|
        format.html { redirect_to(certifications_url) }
        format.js   { render :nothing => true }
  end
end

  def edit
    @certification = Certification.find(params[:id])
    authorize @certification
  end
  
  def update
    @certification = Certification.find(params[:id])
    authorize @certification
    if @certification.update_attributes(certification_params)
      redirect_to certifications_path
    else
      render "new"
    end
  end
  

  def certification_params
  	params.require(:certification).permit(:title)
  end

end
