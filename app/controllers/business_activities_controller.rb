class BusinessActivitiesController < ApplicationController
	def index
		@bus_activity_keyword = BusinessActivity.new
		@keywords = BusinessActivity.all
	end

	def create
		@bus_activity_keyword = BusinessActivity.new(business_activity_params)
		# authorize @certification
		respond_to do |format|
			if @bus_activity_keyword.save
				format.html { redirect_to business_activities_path, notice: 'User was successfully created.' }
				format.js   {}
			end
		end
	end


		def destroy
			@bus_activity_keyword = BusinessActivity.find(params[:id])
			@bus_activity_keyword.destroy
			redirect_to action: "index"
		end
		def business_activity_params
			params.require(:business_activity).permit(:keyword)
		end

	end
