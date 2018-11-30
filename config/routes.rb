Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'dog_walkings/calculate_price', to: 'dog_walkings#calculate_price', as: :dog_walking_calculate_price
      resources :pets
      resources :dog_walkings, only: %i[index show create] do
        resources :dog_walking_positions, only: %i[index show create]
        member do
          get :calculate_price
          put :start_walk
          put :finish_walk
        end
      end

    end
  end
end
