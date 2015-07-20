Rails.application.routes.draw do

  root to: 'home#show'

  resource :account, only: [:show, :edit, :update] do
    member do
      get 'orders', to: 'accounts#orders'
      get 'orders/:order_id/shipping', to: 'accounts#shipping'
      get 'likes', to: 'accounts#likes'
      get 'customisations', to: 'accounts#customisations'
    end
  end

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, path: 'users', path_names: {sign_in: 'sign-in', sign_out: 'sign-out', confirmation: 'verification'}

  mount Ckeditor::Engine => '/ckeditor'

  resources :pages, only: :show
  resources :trends, only: [:show, :index]
  resources :customise, only: [:show, :index]
  resources :shop, only: [:show, :index]
  resources :likes
  

  post 'cart/add-product', to: 'cart#add_product'
  post 'likes/create'
  get 'cart', to: 'cart#show'
  post 'cart/add-dress', to: 'cart#add_dress'
  patch 'cart/update'
  patch 'cart/discount', to: 'cart#apply_discount'
  patch 'cart/gift', to: 'cart#apply_gift_card'
  delete 'cart/delete'

  get 'checkout/user'
  patch 'checkout/process_user', path: 'checkout/process-user'
  get 'checkout/addresses'
  patch 'checkout/pay'
  get 'checkout/ipn'
  match 'checkout/thank_you', via: [:get, :post], path: 'checkout/thank-you'

  namespace :admin do
    root to: 'dashboard#show'
    resources :pages
    resources :posts
    resources :fabrics
    resources :users
    resources :brocades
    resources :embellishments
    resources :products
    resources :dresses
  end

end
