Gh::Application.routes.draw do

  
  root :to => "home#index"
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :confirmations => "users/confirmations"}
  #devise_scope :user do
  #  get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end
  resources :users 
  get "user_steps/tags" => "user_steps#tags", :as => :tags
  
  get "user_steps/state_response"
  get "job_steps/state_response"

  post "job_steps/add_certification"

  resources :certifications
  resources :jobs
  resources :requirements
  resources :locations
  resources :user_steps
  resources :business_activities
  resources :job_steps
  resources :enrollment_steps
end
