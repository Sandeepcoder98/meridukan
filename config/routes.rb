Rails.application.routes.draw do

  concern :resourcable do
    resources :products do
      member do
        get :pricing
        get :shipping_details
        get :publish
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
    get 'set_user_info'=> "registrations#set_user_info"
  end

  resource :home
  resource :dashboard
  resource :search
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
