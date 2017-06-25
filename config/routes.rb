Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations'  }
  resources :profiles do
    get :up_rating, on: :member
  end
  get 'admin' => "admin#index"


  get "sessions/create"

  get "sessions/destroy"
  #get 'profiles/:id', as: 'user_root'
	root 'meetings#index'
	resources :meetings do
    get :participate, on: :member
		resources :comments
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
