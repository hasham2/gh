class RequirementsController < ApplicationController
  
  before_filter :authenticate_user!
  after_action :verify_authorized
  
  def index
   @requirement = Requirement.new
   @requirements = Requirement.all
   authorize @requirements
  end
  
  def create
    @requirement = Requirement.new(certification_params)
    authorize @requirement
    respond_to do |format|
      if @requirement.save
        format.html { redirect_to requirements_path, notice: 'Requirement was successfully created.' }
        format.js   {flash[:notice]= 'Requirement was successfully created.'}
      end
    end
  end

  def destroy
      @requirement = Requirement.find(params[:id])
        authorize @requirement
        if @requirement.destroy
        redirect_to requirements_path, :notice=> "Certification deleted."    
        end
  end

  def certification_params
  	params.require(:requirement).permit(:name)
  end

end
