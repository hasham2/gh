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
        format.html { redirect_to certification_path, notice: 'Certification was successfully created.' }
        format.js   {}
      end
    end
  end
  

  def destroy
   @certification = Certification.find(params[:id])
    authorize @certification
   if @certification.destroy
   redirect_to certifications_url, :notice=> "Certification deleted."
  end

end

  def certification_params
  	params.require(:certification).permit(:title)
  end

end
