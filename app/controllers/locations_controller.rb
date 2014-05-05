# class LocationsController < ApplicationController
#   before_filter :authenticate_user!
#   def new
#   	menu = ["Homedddd","History","Product","Services","ContactUs"]

#   	menu.inject("") do |memo,item|
#   		binding.pry
#   	 # puts memo+""
#   	# puts item.length
#   	 if memo.length<=item.length
#   	 	binding.pry
#   	 	print memo+item
#   	 	binding.pry
#   	 else
#   	 	binding.pry
#   	 	  print memo
#   	 end
#   	end
#   end
  
#   def create
   
#     @location = Location.new(location_params)
#     if @location.save
#     flash[:notice]="Location created successfully"
#    puts flash[:notice]
#    redirect_to :controller => 'home', :action => 'index'
#   else
#     render 'new'
#   end
#   end

#   def edit
    
#   end

#   def subregion_options
#     render partial: 'subregion_select'
#   end
  
# private
# def location_params
#   params.require(:location).permit(:address,:city,:state,:zip,:country,:time_zone,:approx_only,:lat,:lng)  
# end

# end