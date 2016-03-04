Rails.application.routes.draw do

  get 'reports/index'

  concern :resourcable do
    resources :products do
      member do
        get :pricing
        get :shipping_details
        match :publish , via: [:get, :patch]
        match :additional_offers , via: [:get, :patch]
        get :approve
      end
    end
  end

  resources :pricings do
    post :get_pricing,:on=>:collection
  end
  concerns :resourcable

  devise_for :users, :controllers => { :registrations => "registrations", :passwords => "passwords",:sessions=>"sessions" }
  get 'verify-otp' => "social#verify_otp"
  get 'signup' => "social#signup"
  get 'social' => "social#main"

  resource :social, controller:"social" do
    collection do
      post 'verified_otp'
      put 'resend_otp'
    end
  end

  devise_scope :user do
    get 'update_information'=> "registrations#update_information"
  end

  resource :home
  resource :dashboard
  resources :search, only: :index do 
    get :stores, on: :collection
    get :products, on: :collection
  end
  resources :orders, only: [] do 
    get :view_product, on: :collection
    post :add_to_card, on: :collection
  end
  authenticated :user do
    root :to => "dashboard#index", as: :authenticated_root
  end
  root :to => "home#index"

  authenticated :user, ->(u) { u.has_role?(:admin) } do
    namespace :admin do
      resources :dashboard, only: [:index]
      resources :categories do
       resources :sub_categories 
      end
      concerns :resourcable
    end
    get '/admin'=> "admin/dashboards#index"
  end
end
