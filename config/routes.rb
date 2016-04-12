Rails.application.routes.draw do

  resources :user_projects
  resources :uploads
resources :tenants do
  resources :projects
end
 
  resources :projects
  get 'users/dashboard'

  resources :members
  get 'home/index'

   root :to => "home#index"

   get 'dashboard' => 'users#dashboard', as: "user_dashboard"
    
  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do   
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => { 
    :registrations => "registrations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions", 
    :passwords => "milia/passwords", 
  }


end
