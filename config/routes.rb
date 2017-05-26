Rails.application.routes.draw do

  get 'profile' => "profile#show"

  get 'admin' => 'admin#index'

  get 'profile/edit' => 'profile#edit', as: "profile_edit"

  patch 'profile' => 'profile#update'

  get 'profile/new' => 'profile#new', as: "profile_new"

  post 'profile' => 'profile#create'
  
  get 'profile/:id' =>'profile#not_my_profile', as: "not_my_profile"

  controller :sessions do
    get 'login' => :new, as: "login"
    post 'login' => :create
    get 'logout' => :destroy
  end

  get "participate" => "meetings#participate"

  get "sessions/create"

  get "sessions/destroy"

  resources :users
	root 'meetings#index'
	resources :meetings do
		resources :comments
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
