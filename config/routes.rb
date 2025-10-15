Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index, :show] do
        get :find, on: :collection  
        resources :schedules, only: [:index, :show, :create] do
          resources :shows, only: [:create, :destroy, :index]
        end
      end

      resources :festivals, only: [:index, :show] do
        resources :schedules, only: [:index, :create]
        resources :shows, only: [:index]
      end

      get :me, to: "sessions#me"
      delete :logout, to: "sessions#destroy"
    end
  end
end
