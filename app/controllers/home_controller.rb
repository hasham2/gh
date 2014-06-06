class HomeController < ApplicationController
	before_filter :authenticate_user!
	before_action :check_enrollment	
  def index
     @users = User.all
  end
end
