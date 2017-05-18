Rails.application.routes.draw do

  get 'admin' => 'admin#index'

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
