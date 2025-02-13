# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }

  mount MaintenanceTasks::Engine, at: '/maintenance_tasks'
  mount Motor::Admin => '/motor_admin'

  with_admin_auth = lambda do |app|
    Rack::Builder.new do
      use Rack::Auth::Basic do |username, password|
        ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(username), Digest::SHA256.hexdigest(RCreds.fetch(:admin, :username))) &
          ActiveSupport::SecurityUtils.secure_compare(Digest::SHA256.hexdigest(password), Digest::SHA256.hexdigest(RCreds.fetch(:admin, :password)))
      end
      run app
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  mount with_admin_auth.call(MaintenanceTasks::Engine), at: '/maintenance_tasks'

  mount with_admin_auth.call(Sidekiq::Web), at: '/sidekiq'

  # Render dynamic PWA files from app/views/pwa/*
  # get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  # get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  root 'hotels#index'

  resources :hotels, only: :index do
    collection do
      get :search
      get :offers
      get :offer_details
      get :new_booking
      post :create_booking
    end
  end
end
