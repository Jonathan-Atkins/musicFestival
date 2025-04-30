Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index, :show] do
        resources :schedules, only: [:index, :show, :create] do
          resources :shows, only: [:create, :destroy]
        end
      end
            
      resources :festivals, only: [:index, :show] do
        resources :schedules, only: [:index, :create] do
          post 'add_show', to: 'schedules#add_show', as: :add_show
        end
      end
    end
  end
end
