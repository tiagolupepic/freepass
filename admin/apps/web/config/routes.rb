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
