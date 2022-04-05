Rails.application.routes.draw do
  
  # resources :leads
  post 'leads', to: 'leads#create'
  resources :quotes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'home#index'
  get '/residential', to: 'home#residential'
  get '/commercial', to: 'home#commercial'
  get '/quote', to: 'home#quote'
  get '/geo', to: 'home#geo'
  mount Blazer::Engine, at: "blazer"
  # get '/intervention', to: 'home#interventions'
  get '/interventions', to: 'interventions#new'

  get 'interventions/update_buildings' => 'interventions#update_buildings'
 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
