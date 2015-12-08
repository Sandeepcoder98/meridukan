Rails.application.routes.draw do

  resources :products 
  resources :pricings do
    post :get_pricing,:on=>:collection
  end

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
    end
    get '/admin'=> "admin/dashboards#index"
  end
end
