class CertificationsController < ApplicationController
  def index
   @certification = Certification.new
   @certifications = Certification.all
  end
  def create
    @certification = Certification.new(certification_params)
   
    respond_to do |format|
      if @certification.save
        format.html { redirect_to certification_path, notice: 'User was successfully created.' }
        format.js   {}
      end
    end
  end
  def certification_params
  	params.require(:certification).permit(:title)
  end
end
