Rails.application.routes.draw do
  get 'shipments/show'

  root to: 'home#show'
  get 'currencies/switch'
  resources :gift_cards, only: [:index, :new, :create] do
    collection do
      post 'add'
    end
  end
  post 'gift_cards/new', to: 'gift_cards#new'

  resource :account, only: [:show, :edit, :update] do
    member do
      resources :orders
      get 'customisations', to: 'accounts#customisations'
    end
  end

  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}, path: 'users', path_names: {sign_in: 'sign-in', sign_out: 'sign-out', confirmation: 'verification'}

  mount Ckeditor::Engine => '/ckeditor'
  
  resources :search
  resources :pages, only: :show
  resources :trends, only: [:show, :index]
  resources :customise, only: [:show, :index]
  resources :shop, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
  end
  resources :shipments
  resources :likes, only: [:index, :create, :destroy]
  resources :customisations, only: [:index, :create, :destroy]
  resources :customised_dresses, except: [:new, :edit, :update]

  post 'cart/add-product', to: 'cart#add_product'
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
  get 'checkout/paypal_ipn'
  match 'checkout/thank_you', via: [:get, :post], path: 'checkout/thank-you'

  namespace :admin do
    root to: 'dashboard#show'
    resources :pages
    resources :reports, only: [:index]
    resources :posts
    resources :reviews
    resources :fabrics
    resources :custom_sizes
    resources :users
    resources :brocades
    resources :colors
    resources :embellishments
    resources :products 
    resources :dresses do
      resources :fabric_parts_groups
      resources :embellishment_parts_groups
      resources :styles_groups
    end
    resources :discount_coupons
    resources :orders do
      resources :shipments
      resources :order_statuses
    end
  end
end
