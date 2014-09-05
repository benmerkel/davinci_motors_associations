Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'cars#index'

  resources :cars do
    member do
      get 'claim' => 'cars#claim'
    end
    collection do
      get 'my_cars' => 'cars#my_cars'
    end
  end

  resources :users,
    only: [:new, :create],
    path_names: { new: 'signup' }

  get '/login',
    to: 'sessions#login',
    as: 'login'

  get 'verification/:token',
      to: 'users#verify',
      as: 'verify_email'

  post '/login' => 'sessions#create'

  delete '/logout',
    to: 'sessions#destroy'

end
