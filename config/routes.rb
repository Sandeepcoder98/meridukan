Rails.application.routes.draw do
  resources :store, only: [:show] 

  resource :cart, only: [:show, :destroy] do
    get :checkout, on: :collection
  end

  resources :order_items, only: [:create, :update, :destroy] do
    post :quick_add, on: :collection
  end

  concern :resourcable do
    resources :products do
      member do
        get :pricing
        get :shipping_details
        match :publish , via: [:get, :patch]
        match :additional_offers , via: [:get, :patch]
        get :approve
        get :view_product
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
    get 'update_documents'=> "registrations#update_documents"
  end

  resources :seller_documents
  resource :home
  resource :dashboard
  resources :search, only: :index do 
    get :stores, on: :collection
    get :products, on: :collection    
    get :find_stores, on: :collection
  end  

  authenticated :user, ->(u) { u.has_role?(:seller) }do
    root to: 'dashboard#index', as: :authenticated_root
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

  # API structure
  namespace :api, defaults: {format: :json} do
    namespace :v1 do

      devise_for :users

      get "/my_store" => "store#my_store"
      resources :store do 
        resources :products, only: :index
      end

      resources :products, except: :index

      resources :search, only: :index do 
        get :stores, on: :collection
        get :products, on: :collection    
      end  
      
    end
  end  
end
