class BusinessActivitiesController < ApplicationController
	
  before_filter :authenticate_user!
  after_action :verify_authorized
  def index
		@bus_activity_keyword = BusinessActivity.new
		@keywords = BusinessActivity.all
		authorize @keywords
	end

	def create
		@bus_activity_keyword = BusinessActivity.new(business_activity_params)
		authorize @bus_activity_keyword
		respond_to do |format|
			if @bus_activity_keyword.save
				format.html { redirect_to business_activities_path, notice: 'keywords as successfully created.' }
				format.js   {}
			end
		end
  end

	def destroy
    @bus_activity_keyword = BusinessActivity.find(params[:id])
    authorize @bus_activity_keyword
    if @bus_activity_keyword.destroy
       redirect_to business_activities_url,:notice=>"Keyword deleted successfully " 
    end
	end
		
    private

    def business_activity_params
			params.require(:business_activity).permit(:keyword)
		end

	end
