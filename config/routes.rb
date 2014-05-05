Gh::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :confirmations => "users/confirmations"}
  #devise_scope :user do
  #  get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end
  get '/user_steps/subregion_options' => 'user_steps#subregion_options'
  resources :users
  resources :certifications
  resources :requirements
   resources :locations
  resources :user_steps
end
