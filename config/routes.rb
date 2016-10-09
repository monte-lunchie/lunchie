Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'

    resources :restaurants, only: [:index, :show, :create], controller: 'api/restaurants'
    resources :orders, only: [:index, :show, :create, :update], controller: 'api/orders'
    resources :user_orders, only: [:create], controller: 'api/user_orders'
  end

  root 'home#index'
end
