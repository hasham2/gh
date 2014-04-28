class RequirementsController < ApplicationController
  def index
   @requirement = Requirement.new
   @requirements = Requirement.all
  end
  def create
    @requirement = Requirement.new(certification_params)
   
    respond_to do |format|
      if @requirement.save
        format.html { redirect_to Requirements_path, notice: 'Requirement was successfully created.' }
        format.js   {}
      end
    end
  end
  def destroy
      @requirement = Requirement.find(params[:id])
        @requirement.destroy
      flash[:notice] = "requirements deleted." 
        respond_to do |format|
          format.html { redirect_to(certifications_url) }
          format.js   { render :nothing => true }
    end
    
  end
  def certification_params
  	params.require(:requirement).permit(:name)
  end
end
