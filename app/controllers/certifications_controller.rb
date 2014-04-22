class CertificationsController < ApplicationController
  def index
   @certification = Certification.new
  end
end
