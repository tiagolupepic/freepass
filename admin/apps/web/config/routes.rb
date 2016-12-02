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

resources :hours
resources :holidays
resources :cards
