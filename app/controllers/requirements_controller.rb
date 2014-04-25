class RequirementsController < ApplicationController
  
  before_filter authenticate_user!
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
        format.html { redirect_to Requirements_path, notice: 'Requirement was successfully created.' }
        format.js   {}
      end
    end
  end

  def certification_params
  	params.require(:requirement).permit(:name)
  end

end
