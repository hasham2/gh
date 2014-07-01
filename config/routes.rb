Gh::Application.routes.draw do

  root :to => "home#index"
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :confirmations => "users/confirmations"}
  #devise_scope :user do
  #  get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  #end
  resources :users 

  get "enrollment_steps/tags" => "enrollment_steps#tags", :as => :tags
  
  get "enrollment_steps/state_response"
  get "job_steps/state_response"

  post "job_steps/add_certification"
  post "job_steps/delete_certification"

  post "job_steps/add_requirement"
  post "job_steps/delete_requirement"
  
  post "job_steps/add_photo"
  post "job_steps/make_primary_photo"
  post "job_steps/delete_photo"
  post "job_steps/save_photo_caption"
  post "job_steps/make_by_default_primary_image"
  post "job_steps/choose_existing_photo"
  post "job_steps/set_employer_address"


  post "jobs/add_photo"
  # post "jobs/make_primary_photo"
  

  post "enrollment_steps/add_photo"
  post "enrollment_steps/make_primary_photo"
  post "enrollment_steps/delete_photo"
  post "enrollment_steps/save_photo_caption"
  
  get "jobs/search"

  resources :certifications
  resources :jobs do
     get :autocomplete_certification_name, :on => :collection
     member do
      post 'make_primary_photo'
      post 'delete_photo'
      post 'save_photo_caption'
      get 'state_response'
     end
  end
  resources :requirements 
  resources :locations
  resources :business_activities
  resources :job_steps
  resources :metric_types
  resources :enrollment_steps do
   put 'set_primary_image', :on => :member
  end
end
