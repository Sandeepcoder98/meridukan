Rails.application.routes.draw do
  match 'orders/index', via: [:get, :post]
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  resources :store, only: [:show] 

  resource :cart, only: [:show, :destroy] do
    get :checkout, on: :collection
    post :step1, on: :collection
    post :check_auth, on: :collection    
    post :step2, on: :collection
    post :step3, on: :collection
    get :step4, on: :collection
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
        post :product_activities
        get :apply_approve
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

  resources :seller_documents do
    get :seller_document_approve,on: :collection
  end
  resource :home
  resource :dashboard, controller:"dashboard" do
    get :manage_sales, on: :collection
    get :inbox, on: :collection
    get :manage_request, on: :collection
    get :buyer_request, on: :collection
    get :my_products, on: :collection
    get :analytics, on: :collection
    get :public_profile_setting, on: :collection
    get :account_setting, on: :collection
    get :account_action, on: :collection
    get :my_buyers, on: :collection
    get :my_sellers, on: :collection
  end

  resources :search, only: :index do 
    get :stores, on: :collection
    get :products, on: :collection    
    get :find_stores, on: :collection
    post :by_address, on: :collection 
  end  

  resources :checkout do 
    collection do
      post :get_started
      post :action_login
      get :resend_otp_password
      get :delivery_address
      post :add_delivery_address
      get :payment_method
      get :cash_on_delivery
    end

    member do
      put :deliver_here
      get :order_response
    end
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

      resources :channels

      resources :products, except: :index

      resources :search, only: :index do 
        get :stores, on: :collection
        get :products, on: :collection    
      end  
      
    end
  end  
end
get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
get '', to: redirect("/#{I18n.default_locale}")
end
