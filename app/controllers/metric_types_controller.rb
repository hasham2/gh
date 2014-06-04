class MetricTypesController < ApplicationController
	  before_filter :authenticate_user!
	  after_action :verify_authorized
	  def index
			@metric_type = MetricType.new
			@metric = MetricType.all
			authorize @metric
		end

		def create
			@metric_type = MetricType.new(metric_type_params)
			authorize @metric_type
			if @metric_type.save
			 redirect_to metric_types_path, notice: 'Metrics has been Created Successfully .' 
			end
	  end

		def destroy
	   @metric_type = MetricType.find(params[:id])
	   authorize @metric_type
	   @metric_type.destroy
	   redirect_to metric_types_url ,notice: 'Metrics has been destroy Successfully .'
		end
private

	  def metric_type_params
		 params.require(:metric_type).permit(:name)
		end
end
