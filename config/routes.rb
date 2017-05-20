Rails.application.routes.draw do

  get 'profile' => "profile#show"

  get 'admin' => 'admin#index'

  get 'profile/:id' =>'profile#not_my_profile', as: "not_my_profile"

  get 'profile/edit' => 'profile#edit', as: "profile_edit"

  patch 'profile' => 'profile#update'

  get 'profile/new' => 'profile#new', as: "profile_new"

  post 'profile' => 'profile#create'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
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
