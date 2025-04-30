Rails.application.routes.draw do
  # Health check route to verify the app's status
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index] do
        resources :schedules, only: [:index, :show] do
          delete 'shows/:show_id', to: 'schedules#destroy', as: :remove_show
        end
      end
  
      resources :festivals, only: [:show, :index] do
        resources :schedules, only: [:index, :create] do
          post 'add_show', to: 'schedules#add_show', as: :add_show
        end
      end
    end
  end
end
