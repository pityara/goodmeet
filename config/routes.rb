Rails.application.routes.draw do

  resources :profiles do
    get :up_rating, on: :member
  end
  get 'admin' => "admin#index"

  controller :sessions do
    get 'login' => :new, as: "login"
    post 'login' => :create
    get 'logout' => :destroy
  end


  get "sessions/create"

  get "sessions/destroy"

  resources :users
	root 'meetings#index'
	resources :meetings do
    get :participate, on: :member
		resources :comments
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
