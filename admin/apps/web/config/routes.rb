# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
get '/', to: 'home#index'

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
