class LocationsController < ApplicationController
  def new
  end
  
  def create
    @location = Location.new(location_params)
  end

  def edit
    
  end

private
def location_params
  params.require(:location).permit(:address,:city,:state,:zip,:country,:approx_only,:lat,:lng)  
end

end