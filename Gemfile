source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.1'
gem 'rails', '4.1.0'
gem 'pg'
#gem 'sqlite3'
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'gmaps-autocomplete-rails', github: 'kristianmandrup/gmaps-autocomplete-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'devise'
gem 'omniauth-facebook'
gem 'devise-async', github: 'kmayer/devise-async', branch: 'sucker-punch' # Needed to add suckerpunch support
gem 'haml-rails'
gem 'pundit'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'sucker_punch', '~> 1.0'
gem 'paperclip', '~> 4.1'
# Geolocations
gem 'geocoder'
gem 'carmen-rails'
# Testing
gem 'shoulda', group: :test
gem 'poltergeist', group: :test
gem 'capybara', group: :test
# Assets
gem 'rails-assets-leaflet-dist', '~> 0.7.2'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :mri_21, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :production do
  gem 'puma'
end
