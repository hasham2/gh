Gh::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :confirmations => "users/confirmations"}
  #devise_scope :user do
  #  get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end
  get '/locations/subregion_options' => 'locations#subregion_options'
  resources :users
  resources :certifications
  resources :requirements
  resources :locations
end
