# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
root to: 'home#index'

resources :users do
  member do
    patch :activated
    patch :inactivated
  end
  collection do
    get :search
  end
end

resources :periods do
  collection do
    get :search
  end
end

resources :holidays do
  collection do
    get :search
  end
end

resources :hours do
  collection do
    get :search
  end
end

resources :holidays
resources :cards
resources :auth, only: [:new, :create]
resources :logout, only: [:create]
resources :events, only: [:index]
