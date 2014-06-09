class HomeController < ApplicationController
  def index
    #@users = User.all
    @georesp = Geocoder.search(request.env['REMOTE_ADDR']) unless Rails.env.development?
  end
end
